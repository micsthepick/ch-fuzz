docker build -t fuzzchsh:v1 .
(cd fuzz-asan || exit; cp ../fuzzchshindocker.sh .;  cp ../gen_seeds.sh . || exit; sh build.sh)
#(cd fuzz-msan || exit; cp ../fuzzchshindocker.sh . || exit; cp ../gen_seeds.sh . ||  exit; sh build.sh)
(cd fuzz-ubsan || exit; cp ../fuzzchshindocker.sh . || exit; cp ../gen_seeds.sh . ||  exit; sh build.sh)
(cd fuzz-no || exit; cp ../fuzzchshindocker.sh . || exit; cp ../gen_seeds.sh . ||  exit; sh build.sh)
