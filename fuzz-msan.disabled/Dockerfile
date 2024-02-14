FROM fuzzchsh:v1 AS fuzzchshmsan

RUN export CFLAGS="-fPIE"
RUN export SUID_CFLAGS="-fPIE"
RUN export SUID_LDFLAGS="-pie"
RUN export CPPFLAGS="-fPIE"
RUN export LDFLAGS="-pie"

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN AFL_USE_MSAN=1 make chsh
RUN cp ./chsh ./chsh.afl
RUN make clean
RUN export AFL_LLVM_CMPLOG=1
RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN AFL_USE_MSAN=1 make chsh
RUN cp ./chsh ./chsh.cmplog
RUN unset AFL_LLVM_CMPLOG

ADD fuzzchshindocker.sh /AFLplusplus/util-linux/fuzzchsh.sh
ADD gen_seeds.sh /AFLplusplus/gen_seeds.sh
RUN sh /AFLplusplus/gen_seeds.sh
