mkdir -p /AFLplusplus/seeds-chsh
filename_increment=0

echo "-s a" > /AFLplusplus/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-s /bin/bash" > /AFLplusplus/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo '-s "/bin/bash" gues' > /AFLplusplus/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "admn" > /AFLplusplus/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "sshd" > /AFLplusplus/seeds-chsh/$filename_increment.dict;

mkdir -p /AFLplusplus/seeds-chfn
filename_increment=0

echo "-f a" > /AFLplusplus/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-h 0123" > /AFLplusplus/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-o root" > /AFLplusplus/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-r 1" > /AFLplusplus/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-R /" > /AFLplusplus/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-u" > /AFLplusplus/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-w 0321" > /AFLplusplus/seeds-chfn/$filename_increment.dict;

