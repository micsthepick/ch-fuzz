FROM fuzzchsh:v1 AS fuzzchshubsan

RUN export CFLAGS="-fPIE"
RUN export SUID_CFLAGS="-fPIE"
RUN export SUID_LDFLAGS="-pie"
RUN export CPPFLAGS="-fPIE"
RUN export LDFLAGS="-pie"

RUN ./configure --enable-static-programs=chfn,chsh --disable-all-programs --enable-chfn-chsh --disable-chfn-chsh-password
RUN make chsh

ADD fuzzchshindocker.sh /AFLplusplus/util-linux/fuzzchsh.sh
ADD gen_seeds.sh /AFLplusplus/gen_seeds.sh
RUN sh /AFLplusplus/gen_seeds.sh
