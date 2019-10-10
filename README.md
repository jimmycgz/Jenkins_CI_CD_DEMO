# DEMO of CICD Pipeline with Jenkins, AWS, GCP and Azure

### Last Update ###

* Test again at Jul 24, refined the code for deployment.

* Demo for Web Service in Cloud using container and DevOps Pipeline

* Have toolserver and test environment in AWS, Production instances in GCP and Azure

* trigger multiple Pipeline projects in Jenkins for Integration, Build, Test, Deploy to Dev and Production.

### Features and Steps ###

This assignment accomplish below tasks:

1. Setup a Dev Admin server and install AWS CLI, Docker and Jenkins
2. Implement a web application that is deployed across at least two availability zones within a single region in AWS, with load balance and auto-scaling.
3. The application should be accessible over a secure connection (self-signed certs are ok)
4. Build a Multy-AZ RDS instances to return a value from a database, with load balance and data replicate
5. Clean up all of the resources I used for this assignment
6. Document all manual and scripting steps, possible with architecture diagram and workflow


# Steps to make Pipeline Work in Jenkins:
1. Setup webhook
2. Select the 2nd/3rd item Pipeline.  So far I can't make Pipeline Multibranch work.
3. Select Jenkinsfile
4. Add below script for test the trigger SCM Hook

#Features of Web Service
 - All webpages need login. None of the webpages can be accessed for unthorized users even though they can guess the file names.
 - Uses Session Function via PHP, authorized users can access all web pages after one time logging in.
 - The UI of major DEMO web pages are beautified through CSS style.
 - Authorized users can access DB to add new contacts or list the existing contact list.
 
Test LOG:
* Successfully executed with Jenkins Pipeline Declaritive to upload Git Repo from Jenkins $WORKSPACE to S3 bucket at May 8th 2018, details can refer to the comments in Jenkinsfile, but should also check poll SCM after checking SCM hook trigger and set schedule as * * * * * (WORKED!).
* Successfully copied repo from any of two different Jenkins servers in sanbox and my freetrail account to any of S3 buckets (my S3 using my profile credential and Tri-sandbox using given credential).
* Successfully implemented with multiple kind of Jenkins Projects: each commit now can auto-trigger multiple projects simultaneously via both FreesStyle and Pipeline styles (Declarative Syntax)!
* test Bitbucket private repo triggering Jenkins freestyle projects

Developed by Jimmy CUI  May 7th 2018
