resource "aws_s3_bucket" "log_bucket" {
  bucket = "elb-tf-log-bucket"
  acl    = "log-delivery-write"
}
