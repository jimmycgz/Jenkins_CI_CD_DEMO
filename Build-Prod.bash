#!/usr/bin/env bash

# Build the Code package to AWS S3 Bucket as a Production Repository

# Prerequisites: test again at Jul 2018
# Should only run this script via Jenkins Project/Pipeline in order to clone the latest version of code from GitHub to local Jenkins folder before uploading to S3 bucket.
# Should run this script at Admin Tool Server which has both Jenkins and AWS CLI (plus S3) installed & configured.
# If you want to do such work via CLI at Tool Server, make sure to use Git clone the latest version to a local folder and upload to S3 bucket.
# Next step: 
# In each target node, run script Deploy-Prod.sh  to pull the Release from S3 to local and deploy to Web Service Container. It can be copied to Linux HOME folder and add it to startup (reboot) task via crontab -e  
# Ideally add below two lines into Freestyle Build shell section.
#chmod 777 $WORKSPACE/Build-Prod.sh
#$WORKSPACE/Build-Prod.sh

#Issue: fatal error: Unable to locate credentials  Need to install aws plugin and use credentialsbinding
    #//Follow below steps to resolve issue : Unable to locate credentials. You can configure credentials by running "aws configure".
    # //Step0: Read this guide https://docs.aws.amazon.com/systems-manager/latest/userguide/automation-jenkins.html
    #//Step1: In AWS IAM, Create a user account for the Jenkins server , like Jenkins-aws, record the Key ID and Sec Key.
    #//Stpe2: In SHELL of Jenkins server, change to jenkins user and run: sudo su – jenkins  ; aws configure -profile Jenkins-aws // input the key recorded from AWS IAM for Jenkins user like Jenkins-aws
    #//Step3: Sudo su ;  chmod 777 for the two files config and credentials in /var/lib/jenkins/.aws
    #//Step4: Verify AWS S3 command at jenkins linux CLI. DONE setup!!!

    #//Clarify about the users being used by Jenkins, Linux and AWS:
    #// Jenkins application has a customized login name user like jmykinekins,  should be defined right after the first time logging in after installation.
    #// In Linux, Jenkins user is jenkins , fixed, can be found at user group, we can switch to this user via sudo su - jenkins, we can't sudo su the user we created in AWS IAM like Jenkins-aws. 
    #// AWS can use multiple profiles, normally the profile data is stored at $HOME/.AWS, these profile users can be used by the Linux user by presetup: AWS configure -- profile profile_name
    #// The Jenkins-aws user we created from AWS IAM is one of the profiles that AWS can use. It can be used by jenkins user if configure via jenkins in AWS CLI, or it can be used by ubuntu user if you config it at ubuntu CLI.

    #//run below command in this jenkins file in steps under 'Build' stage (just remove // before sh), you'll see Jenkins Pipeline uses Jenkins user to run sh script, and it should be associated with Jenkins-aws the acount account I created in AWS IAM
    # //sh 'whoami'   



# Find the Repo cloned by Jenkins, should be in folder of  $WORKSPACE  like below. NOTE: this varable normally doesn't exist in Linux CLI, only available in Jenkins project. 
#You can verify in Linux CLI by env, ideally you need to add it to Linux system environment.
#cd /var/lib/jenkins/workspace/Jmy-demo-aws1  
cd $WORKSPACE

#Have a copy at this HOME folder then it can be auto executed when server restarts (crontab -e to pre-setup)
date >>$HOME/Jmy-log.txt

# Delete everything in the bucket and upload all files from local to S3 Bucket
aws s3 sync --acl public-read --delete . s3://jmy-bucket-demo2 >>$HOME/Jmy-log.txt


