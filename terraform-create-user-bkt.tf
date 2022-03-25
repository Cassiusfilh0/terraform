
terraform {
  required_version = ">= 0.12"

}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_iam_user" "userbkt" {
  count = 4 
  name = "testedeinfra1"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "test" {
  user = "testedeinfra1"
}

output "aws_iam_smtp_password_v4" {
  value     = aws_iam_access_key.test.ses_smtp_password_v4
  sensitive = true
}

resource "aws_iam_policy" "policy" {
  name = "S3_access"


  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowListingOfUserFolder",
        "Action" : [
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:s3:::sensedata-di-c/"
        ],
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : [
              "sc_upload/*"
            ]
          }
        }
      },
      {
        "Sid" : "AllowAllS3ActionsInUserFolder",
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::sensedata-di-c/sc_upload/*"
        ]
      }
    ]
  })
}
