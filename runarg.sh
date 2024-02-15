export AFL_AUTORESUME=1 AFL_CMPLOG_ONLY_NEW=1 AFL_IMPORT_FIRST=1 AFL_TESTCACHE_SIZE=100MB
[ "$M" == "a" ] && AFL_FINAL_SYNC=1 afl-fuzz -i /outs/seeds-chsh -M sh0 -o out-chsh                         -- ./chsh-san
[ "$M" == "b" ] &&                  afl-fuzz -i /outs/seeds-chsh -S sh1 -o out-chsh -c ./chsh-cmplog -l 2AT -- ./chsh-afl
[ "$M" == "c" ] &&                  afl-fuzz -i /outs/seeds-chsh -S sh2 -o out-chsh -c ./chsh-cmplog        -- ./chsh-afl
[ "$M" == "d" ] &&                  afl-fuzz -i /outs/seeds-chsh -S sh3 -o out-chsh                         -- ./chsh-laf
[ "$M" == "e" ] &&                  afl-fuzz -i /outs/seeds-chsh -S sh4 -o out-chsh                         -- ./chsh-laf
[ "$M" == "f" ] &&                  afl-fuzz -i /outs/seeds-chsh -S sh5 -o out-chsh                         -- ./chsh-laf
[ "$M" == "g" ] && AFL_FINAL_SYNC=1 afl-fuzz -i /outs/seeds-chfn -M fn0 -o out-chfn                         -- ./chfn-san
[ "$M" == "h" ] &&                  afl-fuzz -i /outs/seeds-chfn -S fn1 -o out-chfn -c ./chfn-cmplog -l 2AT -- ./chfn-afl
[ "$M" == "i" ] &&                  afl-fuzz -i /outs/seeds-chfn -S fn2 -o out-chfn -c ./chfn-cmplog        -- ./chfn-afl
[ "$M" == "j" ] &&                  afl-fuzz -i /outs/seeds-chfn -S fn3 -o out-chfn                         -- ./chfn-laf
[ "$M" == "k" ] &&                  afl-fuzz -i /outs/seeds-chfn -S fn4 -o out-chfn                         -- ./chfn-laf
[ "$M" == "l" ] &&                  afl-fuzz -i /outs/seeds-chfn -S fn5 -o out-chfn                         -- ./chfn-laf
