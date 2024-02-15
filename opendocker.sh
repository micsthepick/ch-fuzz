docker run -ti --mount type=bind,source=/chfuzz,destination=/outs --mount type=tmpfs,destination=/ramdisk -e AFL_TMPDIR=/ramdisk fuzzchsh:v2
