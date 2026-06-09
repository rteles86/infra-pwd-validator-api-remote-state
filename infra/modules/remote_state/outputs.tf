output "bucket_name" {
  description = "Nome do bucket S3 para configurar o backend nos demais módulos."
  value       = aws_s3_bucket.this.id
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB para o state lock nos demais módulos."
  value       = aws_dynamodb_table.this.name
}
