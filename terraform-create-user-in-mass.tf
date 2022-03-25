terraform {
  required_version = ">= 0.12"

}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_iam_user" "user_cs" {
  for_each = var.users_cs
  name     = each.value

  tags = {
    tag-key = "time-cs"
  }
}


variable "users_cs" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["matheus.romano", "alessandra.peregrino", "joao.melo", "madson.silva", "raquel.martins", "italo.queiroz", "anapaula.silva", "maria.barros", "gabriel.lima", "erimar.amorim", "matheus.almeida", "luiz.lima", "carolina.souza", "bruno.dias", "camila.sutti", "caio.ribeiro", "ramon.gouvea"]

}

resource "aws_iam_access_key" "usercs" {
  user =  aws_iam_access_key.usercs.name

}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.usercs.ses_smtp_password_v4
}


resource "aws_iam_user" "user_devs" {
  for_each = var.users_devs
  name     = each.value

  tags = {
    tag-key = "time-devs"
  }
}


variable "users_devs" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["caio.martins", "marcos.braga", "guilherme.duarte", "gustavo.ourique", "bruno.borguesan", "leonardo.amaral", "mauricio.murakami", "raphael.cordeiro", "guilherme.leite", "lucas.martiniano", "mauricio.costa", "raphael.oliveira"]

}

resource "aws_iam_access_key" "userdevs" {
  user =  aws_iam_access_key.userdevs.name

}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.userdevs.ses_smtp_password_v4
}
