terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "sensedata-bucket-email-cxx"

  tags = {
    Name = "Bucket e-mail"
  }
}

data "aws_iam_policy_document" "source" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::sensedata-email-cxx/*"]
  }

  statement {
    sid = "Stmt1599741596715"

    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::sensedata-email-cxx/*"]
  }
}


data "aws_iam_policy_document" "allow_access" {
  source_policy_documents = [data.aws_iam_policy_document.source.json]

}
