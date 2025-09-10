Go to the AWS console

Create an S3 bucket 

Bucket Name : Java-WebApp-Artifact-Bucket-OF    (Ensure the Bucket is in thesame region as your CodeBuild Job)   In prod scenario  enable versioning.

search and select CodeBuild

Create Build Project

Project Name :  java-webapp-cb-job

Project Type : Default Project

Additional config ( Depending on your requirements, configure)

Source : Github    ( Or wherever the source is stored )

Repository Type : Repository in my github account

click on  (  Manage account credentials )

Credential Type : Select OAuth App

Service : CdeBuild ( Since we are not using any secret manager if we want to use secret manager we will select secrets manager)

Select : Connect to GitHub

Then authorize and provide your credentials 

You can carry out multiple builds and build concurrently 

Click inside the Repository url box : You will see all your repos in your GutHub ccount 

Select the one your code is in 

Source Version : main

check webhook

single build 

Provision model : on- demand     ( What type of instance you want to use for the job)

Environment Imane : Managed Image    ( Or select custom image if you have a custom image you want t use if you have specific configuratins that must be met)

Compute : EC2

Running mode : container 

Operating system : Amazon Linux        (Select whichever operating system works best for your set up.  You might need to test...)

Runtime : Standard 

Image :  amazonlinux-86_64standard:corretto11      ( The Corretto  is based on Java Apps. Always go for the latest version of the Image )

Image Version : Always use the latest runtime version

Role Name : CodeBuild will always create role for the job but if you have a specific role you want to use for the job, you can always create the role and use it.

CodeBuild can modify the role according to what it needs 

You might run a build that experiences a loop and get stuck there and setting a timer is important    ( 1hr is okay)

Check the Priviledged box

Some App builds take time and require high compute, you can assign the a higher compute to the container that will be runnin the build.

In our BuildSpec  we installed Corretto11 as a dependency for the container to be spinned up'

In our pre-build phase , Apache Maven  and you can install any tool that your build needs in the pre-build phase 

Build-Phase : The command that packages our application using maven   ( mvn clean package ) cleans previous builds and packages the app

Post-Build phase :    We will input the directory path we want to store our file as in S3


e.g 

artifacts:
  files:
    - target/*.war

    if you go inside target directory you will find the war file there ( The Artifact)  


Build specifications : Use a buildspec file 

if you have another name for your buildspec, specify it here, if not, leave it blank, Aws intelligence will look for buildspec.yml

Artifacts: Amazon s3

Select your bucket you just created

Artifact Packaging : none     ( Or Zip if you want to deploy a zip file)

check the Cloudwatch logs  

create build project

Select Start Build

To see the overview what is going on in the job   

click Phase details

If you check your S3 bucket inside the Target directory you will see the webapp