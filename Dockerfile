FROM aflplusplus/aflplusplus as fuzzchsh

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    gettext autopoint

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
RUN export AFL_LLVM_LAF_ALL=1

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN AFL_USE_UBSAN=1 make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-ubsan
RUN mv chfn chfn-ubsan

RUN CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-16 AR=llvm-ar-16 AS=llvm-as-16 \
    ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN AFL_USE_ASAN=1 make chsh chfn

RUN chmod u+s chsh chfn
RUN mv chsh chsh-asan
RUN mv chfn chfn-asan

RUN useradd -s /bin/bash -g root -G sudo -u 1001 admn
RUN useradd -s /bin/bash -u 1002 gues

ADD gen_seeds.sh /AFLplusplus/gen_seeds.sh
RUN sh /AFLplusplus/gen_seeds.sh



