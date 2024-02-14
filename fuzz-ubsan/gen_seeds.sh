mkdir -p /AFLplusplus/seeds
filename_increment=0

echo "-s a" > /AFLplusplus/seeds/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-s /bin/bash" > /AFLplusplus/seeds/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo '-s "/bin/bash" gues' > /AFLplusplus/seeds/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "admn" > /AFLplusplus/seeds/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "sshd" > /AFLplusplus/seeds/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
