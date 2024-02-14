Plan:

[X] download AFL++ Docker
[-] source install chsh for AFL annotations
  [X] find source
  [X] add to dockerfile
  [X] figure out how to configure build?
     [X] mark chsh as part of build with correct suid bit and permissions etc.
  [X] build docker

[X] find something to fuzz:
  [X] command line arguments?
[X] method:
  [X] 2 calls to main:
  with "fuzzy" inputs
  with regular /bin/sh input
  ensure nothing external changes


##  NOTES
from https://github.com/util-linux/util-linux/blob/master/Documentation/howto-compilation.txt:
Compiling

	Use SUID_CFLAGS and SUID_LDFLAGS when you want to define
	special compiler options for typical suid programs, for
	example:

	./configure SUID_CFLAGS="-fpie" SUID_LDFLAGS="-pie"

	The SUID_* feature is currently supported for chfn, chsh,
	newgrp, su, write, mount, and umount.