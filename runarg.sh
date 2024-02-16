export AFL_AUTORESUME=1 AFL_CMPLOG_ONLY_NEW=1 AFL_IMPORT_FIRST=1 AFL_TESTCACHE_SIZE=100MB
[ "$M" == "a" ] && mkdir -p /ramdisk/tmp00 && AFL_TMPDIR=/ramdisk/tmp00 AFL_FINAL_SYNC=1 afl-fuzz -i /outs/seeds-chsh -M sh0 -o out-chsh                         -- ./chsh-san
[ "$M" == "b" ] && mkdir -p /ramdisk/tmp01 && AFL_TMPDIR=/ramdisk/tmp01                  afl-fuzz -i /outs/seeds-chsh -S sh1 -o out-chsh -c ./chsh-cmplog -l 2AT -- ./chsh-afl
[ "$M" == "c" ] && mkdir -p /ramdisk/tmp02 && AFL_TMPDIR=/ramdisk/tmp02                  afl-fuzz -i /outs/seeds-chsh -S sh2 -o out-chsh -c ./chsh-cmplog        -- ./chsh-afl
[ "$M" == "d" ] && mkdir -p /ramdisk/tmp03 && AFL_TMPDIR=/ramdisk/tmp03                  afl-fuzz -i /outs/seeds-chsh -S sh3 -o out-chsh                         -- ./chsh-laf
[ "$M" == "e" ] && mkdir -p /ramdisk/tmp04 && AFL_TMPDIR=/ramdisk/tmp04                  afl-fuzz -i /outs/seeds-chsh -S sh4 -o out-chsh                         -- ./chsh-laf
[ "$M" == "f" ] && mkdir -p /ramdisk/tmp05 && AFL_TMPDIR=/ramdisk/tmp05                  afl-fuzz -i /outs/seeds-chsh -S sh5 -o out-chsh                         -- ./chsh-laf
[ "$M" == "g" ] && mkdir -p /ramdisk/tmp06 && AFL_TMPDIR=/ramdisk/tmp06 AFL_FINAL_SYNC=1 afl-fuzz -i /outs/seeds-chfn -M fn0 -o out-chfn                         -- ./chfn-san
[ "$M" == "h" ] && mkdir -p /ramdisk/tmp07 && AFL_TMPDIR=/ramdisk/tmp07                  afl-fuzz -i /outs/seeds-chfn -S fn1 -o out-chfn -c ./chfn-cmplog -l 2AT -- ./chfn-afl
[ "$M" == "i" ] && mkdir -p /ramdisk/tmp08 && AFL_TMPDIR=/ramdisk/tmp08                  afl-fuzz -i /outs/seeds-chfn -S fn2 -o out-chfn -c ./chfn-cmplog        -- ./chfn-afl
[ "$M" == "j" ] && mkdir -p /ramdisk/tmp09 && AFL_TMPDIR=/ramdisk/tmp09                  afl-fuzz -i /outs/seeds-chfn -S fn3 -o out-chfn                         -- ./chfn-laf
[ "$M" == "k" ] && mkdir -p /ramdisk/tmp10 && AFL_TMPDIR=/ramdisk/tmp10                  afl-fuzz -i /outs/seeds-chfn -S fn4 -o out-chfn                         -- ./chfn-laf
[ "$M" == "l" ] && mkdir -p /ramdisk/tmp11 && AFL_TMPDIR=/ramdisk/tmp11                  afl-fuzz -i /outs/seeds-chfn -S fn5 -o out-chfn                         -- ./chfn-laf
