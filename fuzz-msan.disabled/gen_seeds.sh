mkdir -p /AFLplusplus/seeds
filename_increment=0
for i in root admn sshd gues; do
    for exe in /bin/bash /bin/dash a; do
        echo "$i$exe" >> /AFLplusplus/seeds/$filename_increment.dict;
        filename_increment=$((filename_increment + 1))
    done
done
