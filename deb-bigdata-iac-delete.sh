######Delete S3 Object
aws s3api delete-object --bucket deb-bigdata-lambda-s3bucket --key inbound/
aws s3api delete-object --bucket deb-bigdata-lambda-s3bucket --key intermediate/
aws s3api delete-object --bucket deb-bigdata-lambda-s3bucket --key outbound/

######Delete Bucket
aws s3 rb s3://deb-bigdata-lambda-s3bucket

######Detach Managed Policies
aws iam detach-role-policy --role-name deb-bigdata-fileuploader-lambdaexecrole --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess

aws iam detach-role-policy --role-name deb-bigdata-fileuploader-lambdaexecrole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole

aws iam detach-role-policy --role-name deb-bigdata-fileuploader-lambdaexecrole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws iam detach-role-policy --role-name deb-bigdata-fileuploader-lambdaexecrole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole

######Delete Role
aws iam delete-role --role-name deb-bigdata-fileuploader-lambdaexecrole
