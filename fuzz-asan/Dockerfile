FROM fuzzchsh:v1 as fuzzchshasan

RUN export CFLAGS="-fPIE"
RUN export SUID_CFLAGS="-fPIE"
RUN export SUID_LDFLAGS="-pie"
RUN export CPPFLAGS="-fPIE"
RUN export LDFLAGS="-pie"
RUN export AFL_LLVM_LAF_ALL=1

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN AFL_USE_ASAN=1 make chsh

ADD fuzzchshindocker.sh /AFLplusplus/util-linux/fuzzchsh.sh
ADD gen_seeds.sh /AFLplusplus/gen_seeds.sh
RUN sh /AFLplusplus/gen_seeds.sh
