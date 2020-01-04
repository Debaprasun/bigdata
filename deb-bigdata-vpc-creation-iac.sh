###### Create VPC -- default Route Table & NACL get created
vpc_id=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
###### Tag VPC
aws ec2 create-tags --tags Key=Name,Value=deb-bigdata-lambda-vpc --resources $vpc_id

###### Get the Default Route Table 
default_route_table=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc_id" --query 'RouteTables[*].RouteTableId' --output text)


###### Create Subnets
pub_subnet_id=$(aws ec2 create-subnet --availability-zone us-east-1a --vpc-id $vpc_id --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)
###### Tag the pub subnet
aws ec2 create-tags --tags Key=Name,Value=deb-bigdata-lambda-pubsubnet --resources $pub_subnet_id

pvt_subnet_id=$(aws ec2 create-subnet --availability-zone us-east-1a --vpc-id $vpc_id --cidr-block 10.0.2.0/24 --query 'Subnet.SubnetId' --output text)
###### Tag the pvt subnet 
aws ec2 create-tags --tags Key=Name,Value=deb-bigdata-lambda-pvtsubnet --resources $pvt_subnet_id


###### Create a Custom Route Table
custom_route_table=$(aws ec2 create-route-table --vpc-id $vpc_id --query 'RouteTable. RouteTableId' --output text)

###### Custom Route Table Association w/Pvt Subnet
aws ec2 associate-route-table --route-table-id $custom_route_table --subnet-id $pvt_subnet_id


###### Create a S3 Gateway Endpoint and associate w/Custom Route Table
aws ec2 create-vpc-endpoint --vpc-id $vpc_id --service-name com.amazonaws.us-east-1.s3 --route-table-ids $custom_route_table


###### Create Internet Gateway
igw_id=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)

###### Attach Internet Gateway to VPC
aws ec2 attach-internet-gateway --internet-gateway-id $igw_id --vpc-id $vpc_id

###### Add Route to Internet >> Default Route Table
aws ec2 create-route --route-table-id $default_route_table --destination-cidr-block 0.0.0.0/0 --gateway-id $igw_id
