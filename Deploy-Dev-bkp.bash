#!/usr/bin/env bash
#Deploy to AWS Dev Instance Ubuntu where has Jenkins installed.

#If you are building the CI Dev Project on a brand new server, you'll need to run this script via CLI first to initialize the environment and then add below two lines into Jenkins FreeStyle Project Build Section
#chmod 777 /var/lib/jenkins/workspace/Jmy-demo-aws-1/Deploy-Dev.sh
#/var/lib/jenkins/workspace/Jmy-demo-aws-1/Deploy-Dev.sh
# JENKINS_HOME	/var/lib/jenkins

#If jenkins reports error "Deploy-Dev.sh" not found, just indicate the folder where Jenkins download the repo from GitHub
#/var/lib/jenkins/workspace/Jmy-demo-aws-1$

#Should grant root permission to user: jenkins in CLI.
#Or it will denied if no permission, should already grant full permission to jenkins user :jenkins or jmycgz and restart Jenkins and docker. like 

#Optimized steps for simplified clone
echo $WORKSPACE

cd /home/ubuntu 
rm -rf jmy-demo-web-aws1 ||true

git clone https://github.com/jimmycgz/jmy-demo-web-aws1.git
cd jmy-demo-web-aws1

#docker image rm -f $(docker images -aq)
sudo docker rm -f docker-php-hello  || true 

#Build the code container and publish th web service
sudo docker build -t webphp1hello /home/ubuntu/jmy-demo-web-aws1/
sudo docker run --name=docker-php-hello -d -it -p 80:80 webphp1hello
