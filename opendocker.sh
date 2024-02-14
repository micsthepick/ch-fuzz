if [[ -z "$FUZZER" ]]; then
    echo "Please provide FUZZER environment var!"
    exit
fi
docker run -ti --mount type=tmpfs,destination=/ramdisk -e AFL_TMPDIR=/ramdisk fuzzchsh:$FUZZER
