#!/bin/bash
afl-fuzz -i ../seeds -o output -c ./chsh.cmplog -m none ./chsh.afl
