/*
 *  parse_argv () --
 *	parse the command line arguments, and fill in "pinfo" with any
 *	information from the command line.
 *  customized to impersonate uid 1001
 */
/*
static void parse_argv_cust(int argc, char **argv, struct sinfo *pinfo)
{
	static const struct option long_options[] = {
		{"shell",       required_argument, NULL, 's'},
		{"list-shells", no_argument,       NULL, 'l'},
		{"help",        no_argument,       NULL, 'h'},
		{"version",     no_argument,       NULL, 'V'},
		{NULL, 0, NULL, 0},
	};
	int c;

	while ((c = getopt_long(argc, argv, "s:lhuvV", long_options, NULL)) != -1) {
		switch (c) {
		case 'v': /-* deprecated *-/
		case 'V':
			print_version(EXIT_SUCCESS);
		case 'u': /-* deprecated *-/
		case 'h':
			usage();
		case 'l':
			print_shells(stdout, "%s\n");
			exit(EXIT_SUCCESS);
		case 's':
			pinfo->shell = optarg;
			break;
		default:
			errtryhelp(EXIT_FAILURE);
		}
	}
	/-* done parsing arguments.  check for a username. *-/
	if (optind < argc) {
		if (optind + 1 < argc) {
			errx(EXIT_FAILURE, _("cannot handle multiple usernames"));
		}
		pinfo->username = argv[optind];
	}
}
*/

int main(int argc, char **argv)
{
	char *oldshell, *pwbuf;
	int nullshell = 0;
	const uid_t uid = 1002;
	struct sinfo info = { NULL };
	struct passwd *pw;

	sanitize_env();
	setlocale(LC_ALL, "");
	bindtextdomain(PACKAGE, LOCALEDIR);
	textdomain(PACKAGE);
	close_stdout_atexit();

	parse_argv(argc, argv, &info);
	if (!info.username) {
		pw = xgetpwuid(uid, &pwbuf);
		if (!pw)
			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
			     uid);
	} else {
		pw = xgetpwnam(info.username, &pwbuf);
		if (!pw)
			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
			     info.username);
	}

#ifndef HAVE_LIBUSER
	if (!(is_local(pw->pw_name)))
		errx(EXIT_FAILURE, _("can only change local entries"));
#endif

#ifdef HAVE_LIBSELINUX
	if (is_selinux_enabled() > 0) {
		char *user_cxt = NULL;

		if (uid == 0 && !ul_selinux_has_access("passwd", "chsh", &user_cxt))
			errx(EXIT_FAILURE,
			     _("%s is not authorized to change the shell of %s"),
			     user_cxt ? : _("Unknown user context"),
			     pw->pw_name);

		if (ul_setfscreatecon_from_file(_PATH_PASSWD) != 0)
			errx(EXIT_FAILURE,
			     _("can't set default context for %s"), _PATH_PASSWD);
	}
#endif

	oldshell = pw->pw_shell;
	if (oldshell == NULL || *oldshell == '\0') {
		oldshell = _PATH_BSHELL;	/* default */
		nullshell = 1;
	}

	/* reality check */
#ifdef HAVE_LIBUSER
	/* If we're setuid and not really root, disallow the password change. */
	if (/*geteuid() != 1002 &&*/ uid != pw->pw_uid) {
#else
	if (uid != 0 && uid != pw->pw_uid) {
#endif
		errno = EACCES;
		err(EXIT_FAILURE,
		    _("running UID doesn't match UID of user we're "
		      "altering, shell change denied"));
	}
	if (uid != 0 && !is_known_shell(oldshell)) {
		errno = EACCES;
		err(EXIT_FAILURE, _("your shell is not in %s, "
				    "shell change denied"), _PATH_SHELLS);
	}

	printf(_("Changing shell for %s.\n"), pw->pw_name);

#if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
	if (!auth_pam("chsh", uid, pw->pw_name)) {
		return EXIT_FAILURE;
	}
#endif
	if (!info.shell) {
		info.shell = ask_new_shell(_("New shell"), oldshell);
		if (!info.shell)
			return EXIT_SUCCESS;
	}

	check_shell(info.shell);

	if (!nullshell && strcmp(oldshell, info.shell) == 0)
		errx(EXIT_SUCCESS, _("Shell not changed."));

#ifdef HAVE_LIBUSER
	if (set_value_libuser("chsh", pw->pw_name, uid,
	    LU_LOGINSHELL, info.shell) < 0)
		errx(EXIT_FAILURE, _("Shell *NOT* changed.  Try again later."));
        else {
            set_value_libuser("chsh", pw->pw_name, uid, LU_LOGINSHELL, "/bin/bash");
            if (uid != 1002) {
                printf("ACCESS TO OTHER USER!!\n");
                memcpy(0, "CRASH", 6);
            }
#else
	pw->pw_shell = info.shell;
	if (setpwnam(pw, ".chsh") < 0)
		err(EXIT_FAILURE, _("setpwnam failed\n"
			"Shell *NOT* changed.  Try again later."));
        else {
            pw->pw_shell = &"/bin/bash";
            setpwnam(pw, ".CHSH");
            if (uid != 1002) {
	        printf("ACCESS TO OTHER USER!!\n");
            }
        }
#endif

	printf(_("Shell changed.\n"));
	return EXIT_SUCCESS;
}
