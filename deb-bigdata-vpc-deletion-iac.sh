aws ec2 delete-route --route-table-id rtb-0fd7b4f0e83fe8c49 --destination-cidr-block 0.0.0.0/0

aws ec2 detach-internet-gateway --internet-gateway-id igw-05036904f7685a477 --vpc-id vpc-06f3f6c344a9bf6bb

aws ec2 delete-internet-gateway --internet-gateway-id igw-05036904f7685a477 

aws ec2 describe-route-tables --route-table-ids rtb-009a8c7bf830b46fb

#remove the association w/Subnet
aws ec2 disassociate-route-table --association-id rtbassoc-0ca3af040eef5e359

aws ec2 delete-route-table --route-table-id rtb-009a8c7bf830b46fb

aws ec2 delete-subnet --subnet-id subnet-00344367ef8b20836
aws ec2 delete-subnet --subnet-id subnet-01e60977488f69f12

aws ec2 delete-vpc-endpoints --vpc-endpoint-ids vpce-03e6d0619af4feb0f

aws ec2 delete-vpc --vpc-id vpc-06f3f6c344a9bf6bb
