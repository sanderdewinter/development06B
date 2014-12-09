if [ "$(whoami)" != "root" ];
then
	echo "Must be root to run script"
	exit 1
fi

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/aptsources.list
apt-get update
apt-get install jenkins
