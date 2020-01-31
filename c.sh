#!/bin/bash

aws s3 sync ci s3://mypublicfiles1/qs-workshop/ci/ --delete --acl public-read
aws s3 sync submodules s3://mypublicfiles1/qs-workshop/submodules/ --delete --acl public-read
aws s3 sync templates s3://mypublicfiles1/qs-workshop/templates/ --delete --acl public-read

aws cloudformation create-stack --stack-name demo \
    --template-url https://s3.amazonaws.com/mypublicfiles1/qs-workshop/templates/master.template.yaml \
    --parameters ParameterKey=KeyPairName,ParameterValue=qsworkshop \
                 ParameterKey=RemoteAccessCIDR,ParameterValue=0.0.0.0/0 \
                 ParameterKey=WebserverCIDR,ParameterValue=0.0.0.0/0 \
                 ParameterKey=EmailAddress,ParameterValue=egarcia@progress.com \
		 ParameterKey=AvailabilityZones,ParameterValue=us-east-1a \
                 ParameterKey=QSS3BucketName,ParameterValue=mypublicfiles1 \
                 ParameterKey=QSS3KeyPrefix,ParameterValue=qs-workshop/

#    --template-body file:///home/ec2-user/environment/qs-workshop/templates/master.template.yaml \
#    --parameters ParameterKey=KeyName,ParameterValue=MyKeyPair
#                 ParameterKey=AccessKey,ParameterValue=$AWS_ACCESS_KEY_ID \
#                 ParameterKey=SecretAccessKey,ParameterValue=$AWS_SECRET_ACCESS_KEY
