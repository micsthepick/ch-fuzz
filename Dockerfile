FROM aflplusplus/aflplusplus as fuzzchsh

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    gettext autopoint

RUN git clone https://github.com/util-linux/util-linux.git
WORKDIR /AFLplusplus/util-linux
RUN ./autogen.sh

RUN sed -r 's/int main\(/static int old_main\(/g' /AFLplusplus/util-linux/login-utils/chsh.c > /AFLplusplus/util-linux/login-utils/chsh-mainless.c
ADD persistent.c /AFLplusplus/util-linux/login-utils/persistent.c1
RUN mv /AFLplusplus/util-linux/login-utils/chsh-mainless.c /AFLplusplus/util-linux/login-utils/chsh.cbak
RUN cat /AFLplusplus/util-linux/login-utils/chsh.cbak /AFLplusplus/util-linux/login-utils/persistent.c1 > /AFLplusplus/util-linux/login-utils/chsh.c

RUN useradd -s /bin/bash -g root -G sudo -u 1001 admn
RUN useradd -s /bin/bash -u 1002 gues
