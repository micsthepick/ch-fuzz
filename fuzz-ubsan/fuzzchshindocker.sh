#!/bin/bash
afl-fuzz -i ../seeds -o output -- ./chsh
