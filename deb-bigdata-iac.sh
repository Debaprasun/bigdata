#!/bin/bash
# Ha hahahahah



for argument in "$@"
do
	key=$(echo $argument | cut -f1 -d=)
	value=$(echo $argument | cut -f2 -d=)

	if [[ "$key" == "ent" ]]
	then
		ent=$value
	else
		if [[ "$key" == "prj" ]]
		then
			prj=$value
		else
			if [[ "$key" == "tech" ]]
			then
				tech=$value
			fi
		fi
	fi
done


#Create S3 Bucket
# TO DO - Check for existence before creating, moving on...
# One way is to use grep on output from aws s3 ls, and then check $? for grep command
# And then use if [[.... else construct on that valueneccccbknjvhtjtivfgvuuuehjldtjbendirkittuece
aws s3 mb s3://$ent-$prj-$tech-s3bucket

#Create keys
aws s3api put-object --bucket $ent-$prj-$tech-s3bucket --key inbound/
aws s3api put-object --bucket $ent-$prj-$tech-s3bucket --key intermediate/
aws s3api put-object --bucket $ent-$prj-$tech-s3bucket --key outbound/

#Remove S3 Bucket
# aws s3 rb s3://$ent-$prj-$tech-s3bucket

#Create Role
aws iam create-role --role-name $ent-$prj-fileuploader-lambdaexecrole --assume-role-policy-document file://deb-bigdata-roletrustpolicy-lambda.json

#Attach Managed Policies
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --role-name $ent-$prj-fileuploader-lambdaexecrole

aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole --role-name $ent-$prj-fileuploader-lambdaexecrole

aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole --role-name $ent-$prj-fileuploader-lambdaexecrole

aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole --role-name $ent-$prj-fileuploader-lambdaexecrole

