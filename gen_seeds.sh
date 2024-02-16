export filepath="../outputs/seeds-chsh/"
mkdir -p $filepath
filename_increment=0


[[ -f $filepath$filename_increment.dict ]] || echo "-s a" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-s /bin/bash" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-s /bin/dash" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "admn" > $filepath$filename_increment.dict;

mkdir -p ../outputs/seeds-chfn
export filepath="../outputs/seeds-chfn/"
filename_increment=0

[[ -f $filepath$filename_increment.dict ]] || echo "-f a" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-h 0123" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-o root" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-r 1" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-R /" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-u" > $filepath$filename_increment.dict;
filename_increment=$((filename_increment + 1));
[[ -f $filepath$filename_increment.dict ]] || echo "-w 0321" > $filepath$filename_increment.dict;

