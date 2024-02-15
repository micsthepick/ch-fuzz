#!/bin/bash
afl-fuzz -i ../seeds-chsh -o output-chsh -- ./chsh
