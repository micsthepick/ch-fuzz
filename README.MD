# fuzzing chsh

- Just as an experiment, to see how it works

## building:

clone repo and open directory

```./build.sh```

## running

```screen, tmux etc```
run in first screen or tmux window
```./opendocker.sh```
then attach with
```docker exec -it **** bash``` - **** can be discovered using docker ps.
```afl-fuzz -i ../seeds-chsh -o out-chsh 