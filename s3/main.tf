resource "aws_s3_bucket" "log_bucket" {
  bucket = "elb-tf-log-bucket"
  acl    = "log-delivery-write"
}

output "bucket_id" {
  value = "${aws_s3_bucket.log_bucket.id}"
}
/*
resource "aws_s3_bucket" "b" {
  bucket = "elb-tf-test-bucket"
  acl    = "private"

  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
    target_prefix = "log/"
  }
}
*/
