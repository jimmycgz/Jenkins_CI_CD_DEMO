#!/usr/bin/env bash
#Deploy to AWS Dev Instance Ubuntu where has Jenkins installed. This can be executed either in CLI or through Jenkins Freestyle Project.

#If you are building the CI Dev Project on a brand new server, you'll need to run this script via CLI first to initialize the environment and then add below two lines into Jenkins FreeStyle Project Build Section
#chmod 777 /var/lib/jenkins/workspace/Jmy-demo-aws1/Deploy-Dev.sh
#/var/lib/jenkins/workspace/Jmy-demo-aws1/Deploy-Dev.sh
# $WORKSPACE=	/var/lib/jenkins/Jmy-demo-aws1  this is where Jenkins stores the Code repo 
#chmod 777 $WORKSPACE/Deploy-Dev.bash
#$WORKSPACE/Deploy-Dev.bash

#If jenkins reports error "Deploy-Dev.sh" not found, just indicate the folder where Jenkins download the repo from GitHub by "Check SCM" command in Jenkinsfile (Pipeline)
#/var/lib/jenkins/workspace/Jmy-demo-aws1$

#Should grant root permission to user: jenkins in CLI.
#Or it will denied if no permission, should already grant full permission to jenkins user :jenkins or jmycgz and restart Jenkins and docker. like 

#Issue found:  sudo: no tty present and no askpass program specified
# Pemission error if don't user sudo
#You need to add Jenkins user to root group ,
# Find the commands in the file Initial_Jenkins_Docker.sh

#echo $WORKSPACE
#echo "Jenkins User="
#echo $USER

#cd /var/lib/jenkins/workspace/Jmy-demo-aws1
cd $WORKSPACE

#docker image rm -f $(docker images -aq)
docker rm -f docker-php-hello  || true 

#Build the code container image from Jenkins workspace folder and deploy to web service instance in this Jenkins server
docker build -t webphp1hello .
docker run --name=docker-php-hello -d -it -p 80:80 webphp1hello
