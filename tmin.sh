#!/bin/bash
# my version
#for f in $(ls seeds-chsh); do afl-tmin -i ./seeds-chsh/$f -o seeds-chsh-tmin/$f -- /AFLplusplus/util-linux/chsh-afl || break; done;
#for f in $(ls seeds-chfn); do afl-tmin -i ./seeds-chfn/$f -o seeds-chfn-tmin/$f -- /AFLplusplus/util-linux/chfn-afl || break; done;

#gpt parallel version
# Function to run afl-tmin on a single file for chsh
minimize_chsh() {
    f=$1
    afl-tmin -i "./seeds-chsh/$f" -o "seeds-chsh-tmin/$f" -- /AFLplusplus/util-linux/chsh-afl || exit 1
}

# Function to run afl-tmin on a single file for chfn
minimize_chfn() {
    f=$1
    afl-tmin -i "./seeds-chfn/$f" -o "seeds-chfn-tmin/$f" -- /AFLplusplus/util-linux/chfn-afl || exit 1
}

export -f minimize_chsh minimize_chfn

# Ensure output directories exist
mkdir -p seeds-chsh-tmin seeds-chfn-tmin

# Run afl-tmin in parallel for chsh files
ls seeds-chsh | parallel minimize_chsh

# Check if the previous command was successful
if [ $? -eq 0 ]; then
    # If successful, proceed with chfn files in parallel
    ls seeds-chfn | parallel minimize_chfn
else
    # If there was a failure, exit
    echo "Error occurred during minimizing chsh seeds. Stopping."
    exit 1
fi
