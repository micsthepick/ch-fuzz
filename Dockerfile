FROM aflplusplus/aflplusplus:dev as fuzzchsh

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    gettext autopoint tmux parallel

RUN git clone https://github.com/util-linux/util-linux.git
WORKDIR /AFLplusplus/util-linux
RUN ./autogen.sh

RUN mv /AFLplusplus/util-linux/login-utils/chsh.c /AFLplusplus/util-linux/login-utils/chsh.c.bak  
RUN sed -r 's/int main\(/static int old_main\(/g' /AFLplusplus/util-linux/login-utils/chsh.c.bak > /AFLplusplus/util-linux/login-utils/chsh-mainless.c
ADD chsh-persistent.c /AFLplusplus/util-linux/login-utils/chsh-persistent.c
RUN cat /AFLplusplus/util-linux/login-utils/chsh-mainless.c /AFLplusplus/util-linux/login-utils/chsh-persistent.c > /AFLplusplus/util-linux/login-utils/chsh.c
RUN mv /AFLplusplus/util-linux/login-utils/chfn.c /AFLplusplus/util-linux/login-utils/chfn.c.bak
ADD chfn-persistent.c /AFLplusplus/util-linux/login-utils/chfn.c

RUN ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-plain
RUN mv chfn chfn-plain

RUN export CFLAGS="-fPIE"
RUN export SUID_CFLAGS="-fPIE"
RUN export SUID_LDFLAGS="-pie"
RUN export CPPFLAGS="-fPIE"
RUN export LDFLAGS="-pie"

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN AFL_USE_ASAN=1 AFL_USE_UBSAN=1 AFL_USE_CFISAN=1 make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-san
RUN mv chfn chfn-san
RUN make clean

RUN export AFL_LLVM_LAF_ALL=1

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-laf
RUN mv chfn chfn-laf
RUN make clean

RUN unset AFL_LLVM_LAF_ALL

RUN export AFL_LLVM_CMPLOG=1

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-cmplog
RUN mv chfn chfn-cmplog
RUN make clean

RUN unset AFL_LLVM_CMPLOG


RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-afl
RUN mv chfn chfn-afl
RUN make clean

RUN useradd -s /bin/bash -g root -G sudo -u 1001 admn
RUN useradd -s /bin/bash -u 1002 gues

ADD runarg.sh /AFLplusplus/util-linux/runarg.sh
ADD cmin.sh /AFLplusplus/util-linux/cmin.sh
ADD run12tmux.sh /AFLplusplus/util-linux/run12tmux.sh
ADD tmin.sh /
