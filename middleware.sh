#! /bin/bash


#Author: Josephine F.
#Date:   26-Oct-2022

#Description: This is a script that will automate the installation of Sonarqube
#             ------ What is Sonarqube? -------
#           Sonarqube is an open-source platform developed 
#           by SonarSource for continous inspection
#           of code quality. Sonarqube does static code analysis, 
#           which provides a detailed report of bugs
#           code smells, vulnerablities and code duplications.              
   
USER_NAME="whoami"

if ${USER_NAME}!=vagrant"
then
echo "You must be logged in as user vagrant to run this script"
exit 29
fi

echo "Thank you for your patience, installation will take a few moments"

echo "installing Java 11"
sudo yum update -y
sudo yum install java-11-openjdk-devel -y
sudo yum install java-11-openjdk -y

echo "Downloading the latest versions of Sonarqube"
cd /opt
sudo yum install wget -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zi

echo "extracting packages"
sudo yum install unzip -y
sudo unzip /opt/sonarqube-9.3.0.51899.zip

echo "Changing ownership to user vagrant" 
sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899

echo "Switching to linux binaries directory to start service"
cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
 ./sonar.sh start

echo "Opening the 9000 port"
sudo firewall-cmd --permanent --add-port=9000/tcpcd
sudo firewall-cmd --reload

echo "what is your name"
read y

echo "Guest what ${y} ?, Sonaqube installation is complete,connect to the sonarqube user
using your ip address. Example: http://<your-ip-address>:9000"

