#comando para dizer que vai rodar qualquer versão do terrafomr a partir da 0.12
terraform {
  required_version = ">= 0.12"
}
#comando de provide - verificar que credenciais de acesso foram passadas como variaveis no cli 
provider "aws" {
  region = "sa-east-1"
}
#Criação do bucket, nome e tags. tags são opicionais mas buscar alinhar quais as tags para criação de bucket, caso tenha. 
resource "aws_s3_bucket" "test_bucket" {
  bucket = "sensedata-di-cxx"

  tags = {
    Name = "Meu bucket"
  }
}
#Criação de pastas que existem nos buckets sc_upload/ sd_upload/ 
resource "aws_s3_object" "folder1" {
  bucket = "sensedata-di-cxx"
  key    = "sc_upload/"

}
#Criação de pastas que existem nos buckets sc_upload/ sd_upload/ 
resource "aws_s3_object" "folder2" {
  bucket = "sensedata-di-cxx"
  key    = "sd_upload/"

}


#Encryotação do bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "exemplo" {
  bucket = "sensedata-di-cxx"

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#configuração de CORS do bucket
resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = "sensedata-di-cxx"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}
