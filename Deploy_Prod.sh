# Auto pull the latest released code from S3 Bucket to local folder and then create new Web service Instance for Production.
# Docker builds the new release to an image and run it as a new container
# Uses sodu for all commands because it'll be executed either via startup task or CLI. 

# This script file will be auto executed when the production servers restart.
# Developed by Jmy
# Log file can be found at $HOME/Jmy-log.txt

# To make it run at server restart, you need to run crontab -e and add below line
# @reboot sh $HOME/Deploy_Prod.sh

# Use below line to run this file in shell CLI in the target server, make sure every line works under CLI or the scrpt file might not execute at startup.
# sh Deploy_Prod.sh

# Ubuntu Home folder echo $HOME =>/home/ubuntu 

# ansible gcp_web_prod -a "sudo reboot"
# So far can't directly integrate ansible and docker with Jenkins, so work around: reboot each instance via ansible playbook to auto deploy by this script.
# Restart the tool server if you meet error like: "error 12: out of memory".
# can also try to create a tag file using below ansible command and setup linux to check this file every 10mins, run deployment and delete this file. 
# ansible gcp_web_prod -a "echo hello >/home/jimmycgz/deploy_start.txt"
# ansible host -m shell -a 'echo hello && echo world'
# sh $HOME/ansi_deploy.sh


# Add time stamp into My Log File
echo "......" >>$HOME/Jmy-log.txt
echo "This script Deploy_Prod.sh got run at below time" >>$HOME/Jmy-log.txt
date >>$HOME/Jmy-log.txt

#Download the whole bucket from S3 to local folder

# Delete the local repo folder and create a new one
cd $HOME/jmy-demo-web-aws1
sudo rm -rf ./*  >>$HOME/Jmy-log.txt

sudo aws s3 sync s3://jmy-bucket-demo1 .  >>$HOME/Jmy-log.txt
cp Deploy_Prod.sh .. >>$HOME/Jmy-log.txt

#Build the code container image from Jenkins workspace folder and deploy to web service instance
docker rm -f docker-php-hello  || true >>$HOME/Jmy-log.txt 
docker rm -f docker-php-demo || true  >>$HOME/Jmy-log.txt
docker build -t jmy-webphp1-prod . >>$HOME/Jmy-log.txt
docker run --name=docker-php-demo -d -it -p 80:80 jmy-webphp1-prod  >>$HOME/Jmy-log.txt
