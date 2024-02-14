
#ifndef __AFL_FUZZ_TESTCASE_LEN
  ssize_t fuzz_len;
  #define __AFL_FUZZ_TESTCASE_LEN fuzz_len
  unsigned char fuzz_buf[1024000];
  #define __AFL_FUZZ_TESTCASE_BUF fuzz_buf
  #define __AFL_FUZZ_INIT() void sync(void);
  #define __AFL_LOOP(x) ((fuzz_len = read(0, fuzz_buf, sizeof(fuzz_buf))) > 0 ? 1 : 0)
  #define __AFL_INIT() sync()
#endif

__AFL_FUZZ_INIT();

/* To ensure checks are not optimized out it is recommended to disable
   code optimization for the fuzzer harness main() */
#pragma clang optimize off
#pragma GCC            optimize("O0")

int main() {
    char *oldshell, *pwbuf;
    int nullshell = 0;
    const uid_t uid = 1002;//getuid();
    // emulate guest
    struct sinfo info = { NULL };
    struct passwd *pw;
    // anything else here, e.g. command line arguments, initialization, etc.

    sanitize_env();
    setlocale(LC_ALL, "");
    bindtextdomain(PACKAGE, LOCALEDIR);
    textdomain(PACKAGE);
    close_stdout_atexit();

    unsigned char *buf = __AFL_FUZZ_TESTCASE_BUF;  // must be after __AFL_INIT
                                                 // and before __AFL_LOOP!

    __AFL_INIT();

    //parse_argv(argc, argv, &info);
    while (__AFL_LOOP(UINT_MAX)) {
        int len = __AFL_FUZZ_TESTCASE_LEN;
        if (len < 4) continue;
        char uname[5];
        memcpy(uname, buf, 4);
        uname[4] = '\0';
        buf[len-1] = '\0';

        info.shell = &buf[4];
        info.username = &uname;


        if (!info.username) {
            pw = xgetpwuid(uid, &pwbuf);
            if (!pw) {
                printf("you usr %d\n", uid);
                continue;//memcpy(0, "crashme", 10);// force crash to diagnose bug in this wrapper
            }
                //errx(EXIT_FAILURE, _("you (user %d) don't exist."),
                    //uid);
        } else {
            pw = xgetpwnam(info.username, &pwbuf);
            if (!pw) {
                printf("does not exist: %s\n", info.username);
                continue;//memcpy(0, "crashme", 10); // considered bug with wrapper, don't waste time guessing 4 letter acct names
//errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
//                    info.username);
            }
        }

    #ifndef HAVE_LIBUSER
        if (!(is_local(pw->pw_name))) {
            printf("nonlocal");
            memcpy(0, "crashme", 10);
        }
            //errx(EXIT_FAILURE, _("can only change local entries"));
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
        if (geteuid() != getuid() && uid != pw->pw_uid)
    #else
        if (uid != 0 && uid != pw->pw_uid)
    #endif
        {
            errno = EACCES;
            continue;
            err(EXIT_FAILURE,
                _("running UID doesn't match UID of user we're "
                "altering, shell change denied"));
        }
        if (uid != 0 && !is_known_shell(oldshell)) {
            errno = EACCES;
            continue;
            err(EXIT_FAILURE, _("your shell is not in %s, "
                        "shell change denied"), _PATH_SHELLS);
        }

        if (strcmp(pw->pw_name, "gues")) {
            printf("not gues account, but we are attempting to change shell\n");
            memcpy(0, "crashme", 10);// force crash
        }
//printf(_("Changing shell for %s.\n"), pw->pw_name);

#if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
	//if (!auth_pam("chsh", uid, pw->pw_name)) {
	//	return EXIT_FAILURE;
	//}
#endif
    if (strcmp(pw->pw_name, "gues")) {
        continue; // can't guess another's username
    }
	if (!info.shell) {
		info.shell = ask_new_shell(_("New shell"), oldshell);
		if (!info.shell) {
			// original behaviour ignore and return
			continue;
		}
	}

	check_shell(info.shell);

	if (!nullshell && strcmp(oldshell, info.shell) == 0)
		continue;//errx(EXIT_SUCCESS, _("Shell not changed."));

#ifdef HAVE_LIBUSER
	if (set_value_libuser("chsh", pw->pw_name, uid,
	    LU_LOGINSHELL, info.shell) < 0) {
            continue
        }
        /*
		errx(EXIT_FAILURE, _("Shell *NOT* changed.  Try again later."));
        */
#else
	pw->pw_shell = info.shell;
	if (setpwnam(pw, ".chsh") < 0) {
        continue;
    }
    /*
		err(EXIT_FAILURE, _("setpwnam failed\n"
			"Shell *NOT* changed.  Try again later."));
    */
#endif

    // cleanup
    #ifdef HAVE_LIBUSER
    if (set_value_libuser("chsh", "gues", uid,
        LU_LOGINSHELL, info.shell) < 0) {
            printf("can't clean up (LIBUSR)\n");
            memcpy(0, "crashme", 10);// force crash
        }
    #else
        pw->pw_name = "gues";
        pw->pw_shell = "/bin/bash";
        if (setpwnam(pw, ".chsh") < 0) {
            printf("can't clean up (regular)\n");
            memcpy(0, "crashme", 10);// force crash
    #endif
        }
        free(pw);
        free(pwbuf);
    }

    return EXIT_SUCCESS;
}
//memcpy(0, "crashme", 10);// force crash
