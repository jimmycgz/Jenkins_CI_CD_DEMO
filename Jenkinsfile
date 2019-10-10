pipeline {
    /* Upload the artifact from Jenkins work folder to AWS S3 bucket using Jenkins-aws profile*/
    /* Create a txt file to recrod the Build Tag */
    
    agent any
    stages {
        stage('Integration Test') {
            steps {
                checkout($class:'GitSCM')
                echo 'Test done!' 

            }
        }
		stage('Production Build') {
            steps {
                checkout($class:'GitSCM')
                //run below command in this jenkins file in steps under 'Build' stage (just remove // before sh), you'll see Jenkins Pipeline uses Jenkins user to run sh script, and it should be associated with Jenkins-aws the account I created in AWS IAM
                 sh 'whoami'   
                 sh 'printenv'
                 sh 'echo ".... Build Tag & date ...." >> ../Product_Version.txt ' 
				 sh 'date >> ../Product_Version.txt ' 
				 sh 'echo "Build Number : $BUILD_TAG" >> ../Product_Version.txt ' 
                //BUILD_TAG=jenkins-Jmy-demo-aws1-Prod-Build-pipeline-49
                
                //withAWS(profile:'Jenkins-aws') {
                    withAWS(profile:'Jenkins-aws') {

                    //Copy the repo from Jenkins Workspace folder to S3
                    sh 'aws s3 sync --acl public-read --delete . s3://jmy-bucket-demo1/'
                   
                        //Update Product Release Tag
                   sh 'aws s3 cp ../Product_Version.txt s3://jmy-bucket-demo1/'
                }

            }
        }
    }
                    
// # Should run this script at Admin Tool Server which has both Jenkins and AWS CLI (plus S3) installed & configured. 

 //Follow below steps to resolve issue : Unable to locate credentials. You can configure credentials by running "aws configure ".
 // Need to install Plugin Pipeline: AWS Steps   
 //Step0: Read this guide https://docs.aws.amazon.com/systems-manager/latest/userguide/automation-jenkins.html
//Step1: In AWS IAM, Create a user account for the Jenkins server , like Jenkins-aws, record the Key ID and Sec Key.
//Stpe2: In SHELL of Jenkins server, change to jenkins user and run: sudo su � jenkins  ; aws configure - profile Jenkins-aws // input the key recorded from AWS IAM, associate this profile Jenkins-aws to Linux user jenkins
//Step3: exit jenkins and sudo su to root or switch to ubuntu ;  chmod 640 for the two files config and credentials in /var/lib/jenkins/.aws
//Step4: test if the these two accounts get associated: sudo su -jenkins; aws s3api list-buckets --query "Buckets[].Name" --profile Jenkins-aws  
//Step5: Add 3 Environment variables aws_access_key_id AWS_DEFAULT_REGION aws_secret_access_key with related key values   DONE setup!!!

//Clarification about the users being used by Jenkins, Linux and AWS:
// Jenkins application has a customized login ID like jmykinekins associated with a Nick Name like Jmy,  should be defined right after the first time logging in after installation.
// In Linux, Jenkins service user is jenkins , fixed, use command sudo service jenkins status to check service status , we can switch to this user via sudo su - jenkins, we can't sudo su Jenkins-aws the user we created in AWS IAM . 
// AWS CLI can use multiple profiles, normally the profile data is stored at $HOME/.AWS, these profile users can be used by any users of Linux userGroup by presetup in it's own CLI : AWS configure -- profile profile_name (here it's Jenkins-aws)
// The Jenkins-aws user we created from AWS IAM is one of the profiles that AWS can use. It can be used by the jenkins which pre-configured via jenkins Linux account in AWS CLI, or it can be used by ubuntu user if you config it at ubuntu CLI.

    
    post { 
        always { 
            echo 'Done code build to S3!'
            
           //# Next step: Run script Deploy-Prod.sh in each target node to pull the Release from S3 to local and deploy to Web Service Container. It can be copied to Linux $HOME folder and add it to startup (reboot) task via crontab -e  

        }
    }
}
