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

#Remove S3 Bucket
# aws s3 rb s3://$ent-$prj-$tech-s3bucket
