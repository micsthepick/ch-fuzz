FROM aflplusplus/aflplusplus as fuzzchsh

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    gettext autopoint

RUN git clone https://github.com/util-linux/util-linux.git
WORKDIR /AFLplusplus/util-linux
RUN ./autogen.sh

RUN sed -r 's/int main\(/static int old_main\(/g' /AFLplusplus/util-linux/login-utils/chsh.c > /AFLplusplus/util-linux/login-utils/chsh-mainless.c
ADD chsh-persistent.c /AFLplusplus/util-linux/login-utils/chsh-persistent.c
RUN cat /AFLplusplus/util-linux/login-utils/chsh-mainless.c /AFLplusplus/util-linux/login-utils/chsh-persistent.c > /AFLplusplus/util-linux/login-utils/chsh.c

#RUN sed -r 's/int main\(/static int old_main\(/g' /AFLplusplus/util-linux/login-utils/chfn.c > /AFLplusplus/util-linux/login-utils/chfn-mainless.c
#ADD chfn-persistent.c /AFLplusplus/util-linux/login-utils/chfn-persistent.c
#RUN cat /AFLplusplus/util-linux/login-utils/chfn-mainless.c /AFLplusplus/util-linux/login-utils/chfn-persistent.c > /AFLplusplus/util-linux/login-utils/chfn.c
RUN mv /AFLplusplus/util-linux/login-utils/chfn.c /AFLplusplus/util-linux/login-utils/chfn-bak.c
ADD chfn-persistent.c /AFLplusplus/util-linux/login-utils/chfn.c


RUN useradd -s /bin/bash -g root -G sudo -u 1001 admn
RUN useradd -s /bin/bash -u 1002 gues
