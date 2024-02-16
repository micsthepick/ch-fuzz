 ([ ! -d /outs/seeds-chsh ] || (rm -rf /outs/seeds-chsh.bak && mv /outs/seeds-chsh /outs/seeds-chsh.bak)) && afl-cmin -i ./out-chsh/sh0/queue -o /outs/seeds-chsh -- ./chsh-afl
 ([ ! -d /outs/seeds-chfn ] || (rm -rf /outs/seeds-chfn.bak && mv /outs/seeds-chfn /outs/seeds-chfn.bak)) && afl-cmin -i ./out-chfn/fn0/queue -o /outs/seeds-chfn -- ./chfn-afl
