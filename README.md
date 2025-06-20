Java Application CICD Pipeline

Requirements:

1. 1 Jenkins Server on AWS EC2 instance

   Type: t2.small

   SG config: port 8080 and 22
   
3. 1 Nexus Server on AWS EC2 instance

    Type: t2.medium

   SG config: port 8081 and 22

5. Slack Notification Enabled

6. Ubuntu Server for Accessing the application

   Type: t2.micro

   SG config: port 8080 and 22
