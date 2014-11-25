workingDir=$(pwd)
newDir="$workingDir/newDir"
subDir="$newDir/subDir"
newFile="$newDir/text.txt"

if [ "$(whoami)" != "root" ];
then
	echo "Must be root to run script"
	exit 1
fi

echo "Welcome root on $(date)"
echo "Create or delete"
read input

if [ $input = "create" ];
then
	echo "Creating"
	mkdir $newDir
	mkdir $subDir
	ls
	echo "Random content in txt file" > $newFile
	cd $newDir
	ls
	cd $workingDir

	echo "Add 'user1' and make owner"
	useradd user1
	chown -R user1 $newDir
	ls -l

	echo "Install vim"
	apt-get install vim

	echo "Make symbolic link"
	ln -s $subDir symLink

	echo "Make archive"
	cd $newDir
	tar -zcvf first-archive.tar.gz $subDir
	echo "Content of archive"
	tar -ztvf first-archive.tar.gz

	echo "Put on ftp-server"
	curl -T first-archive.tar.gz ftp://159.253.7.3 --user sandevd93:123456

	echo "Random txt" > /etc/random.txt && echo "Random txt2" > /etc/random2.txt
	cd /etc
	cat random.txt && cat random2.txt
	cd $workingDir

elif [ $input = "delete" ];
then
	echo "Deleting"
	rm -rf $newDir
	ls

	userdel user1

	rm symLink

	curl ftp://159.253.7.3 -X 'DELE first-archive.tar.gz' --user sandevd93:123456

	cd /etc
	rm random.txt && rm random2.txt
	cd $workingDir

else
	echo "Command not found"
fi

echo "Closing"
