#!/bin/bash
afl-fuzz -i ../seeds-chfn -o output-chfn -- ./chfn
