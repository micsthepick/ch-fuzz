mkdir -p ../outputs/seeds-chsh
filename_increment=0

echo "-s a" > ../outputs/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-s /bin/bash" > ../outputs/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo '-s "/bin/bash" gues' > ../outputs/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "admn" > ../outputs/seeds-chsh/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "sshd" > ../outputs/seeds-chsh/$filename_increment.dict;

mkdir -p ../outputs/seeds-chfn
filename_increment=0

echo "-f a" > ../outputs/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-h 0123" > ../outputs/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-o root" > ../outputs/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-r 1" > ../outputs/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-R /" > ../outputs/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-u" > ../outputs/seeds-chfn/$filename_increment.dict;
filename_increment=$((filename_increment + 1));
echo "-w 0321" > ../outputs/seeds-chfn/$filename_increment.dict;

