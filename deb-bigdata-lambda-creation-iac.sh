####create security-group

#aws ec2 delete-security-group --group-id sg-033c7fad3a5547c72

deb_bigdata_lambda_sg_id=$(aws ec2 create-security-group --group-name deb-bigdata-lambda-sg --description "allows lambda to access s3 dynamodb redshift" --vpc-id $vpc_id --query 'GroupId' --output text)

aws ec2 authorize-security-group-ingress \
    --group-id sg-0264632f9c27c0273 \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-id sg-0264632f9c27c0273 \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-id sg-0264632f9c27c0273 \
    --protocol tcp \
    --port 5439 \
    --cidr 0.0.0.0/0

####create and zip the lambda_function.py
zip lambda_function.zip lambda_function.py

####create s3 bucket key “lambdafunction” to store the lambda zip file
aws s3api put-object --bucket $ent-$prj-$tech-s3bucket --key lambdafunction/

####copy lambda zip file to S3
aws s3 cp lambda_function.zip s3://$ent-$prj-$tech-s3bucket/lambdafunction/lambda_function.zip 

####create lambda function
aws lambda create-function \
    --function-name deb-test-function-cli \
    --runtime python3.8 \
    --code S3Bucket=deb-bigdata-lambda-s3bucket,S3Key=lambdafunction/lambda_function.zip \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::075028566286:role/deb-bigdata-fileuploader-lambdaexecrole \
    --vpc-config SubnetIds=subnet-0eab329bd687f7a26,SecurityGroupIds=sg-0264632f9c27c0273


####allow S3 to invoke lambda
aws lambda add-permission \
    --function-name deb-test-function-cli \
    --action lambda:InvokeFunction \
    --statement-id s3 \
    --principal s3.amazonaws.com


####add notification to S3
aws s3api put-bucket-notification-configuration --bucket "deb-bigdata-lambda-s3bucket" --notification-configuration file://notification.json
