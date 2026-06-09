variable "bucket_name" {
  description = "Nome do bucket S3 para armazenar o Terraform state. Deve ser globalmente único."
  type        = string
  default     = ""
}

variable "table_name" {
  description = "Nome da tabela DynamoDB para o state lock distribuído."
  type        = string
  default     = "pwd-validator-tfstate-lock"
}

variable "region" {
  description = "Região AWS onde os recursos serão provisionados."
  type        = string
  default     = "us-east-1"
}
