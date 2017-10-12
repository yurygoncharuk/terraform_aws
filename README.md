# terraform_aws

What does this terraform template?

1) VPC
2) Internet Gateway
3) NAT gateway
4) Two Private and two public Subnets
5) Public Route Table and Public Route
6) Private Route Table and Private Route
7) S3 Bucket
8) Custom security group attached to every instance
9) Two EC2 instances(EBS volumes attached as root device (of type magnetic))
10) Installed Apache on both servers via User Data and customized its welcome page on each server to contain hostname.
11) Two Elastic IP (attached to each instance)
12) Elastic Load Balancer for instances created (ELB port 80 to instance port 80)
