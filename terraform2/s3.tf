#################################
##########  S3 BUCKET  ##########
#################################

## S3 Access ##

resource "aws_iam_instance_profile" "s3_azeaccess" {
    name = "s3_azeaccess"
    roles = ["${aws_iam_role.s3_azeaccess.name}"]
}

resource "aws_iam_role_policy" "s3_azepolicy" {
    name = "s3_azepolicy"
    role = "${aws_iam_role.s3_azeaccess.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "s3_azeaccess" {
    name = "s3_azeaccess"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
  },
      "Effect": "Allow",
      "Sid": ""
      }
    ]
}
EOF
}


resource "aws_s3_bucket" "aze-code" {
   bucket = "s3-bucket-aze00"
   acl = "private"
   force_destroy = true
   tags {
      Name = "aze code bucket"
   }
}
