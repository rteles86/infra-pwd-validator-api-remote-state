# infra-pwd-validator-api-remote-state# password-validator-infra-remote-state

Módulo Terraform que provisiona o **backend de estado remoto** compartilhado por todos os módulos de infraestrutura do projeto.

## Visão Geral

| Recurso | Configuração |
|---|---|
| S3 Bucket | Versionamento habilitado · SSE habilitado · Block public access |
| DynamoDB Table | PAY_PER_REQUEST · hash_key: `LockID` (String) |

> **Este módulo é pré-requisito para todos os demais.** Provisione-o primeiro.

## Pré-requisitos

- Terraform >= 1.7
- AWS CLI com permissões: `s3:CreateBucket`, `s3:PutBucketVersioning`, `dynamodb:CreateTable`
- Backend **local** na primeira execução (bootstrap)

## Estrutura

```
infra/modules/remote_state/
├── main.tf          # aws_s3_bucket, versioning, encryption, public_access_block, dynamodb_table
├── variables.tf     # bucket_name, table_name, region
├── outputs.tf       # bucket_name, dynamodb_table_name
└── versions.tf
```

## Bootstrap (primeira execução)

```bash
cd infra/modules/remote_state

# 1. Inicializar com backend local
terraform init

# 2. Provisionar S3 + DynamoDB
terraform apply

# 3. Adicionar configuração de backend ao versions.tf e migrar state
terraform init -migrate-state
```

## Configuração do Backend nos Demais Módulos

```hcl
terraform {
  backend "s3" {
    bucket         = "<bucket_name>"
    key            = "password-validator/<modulo>/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<dynamodb_table_name>"
    encrypt        = true
  }
}
```

## Outputs

| Output | Descrição |
|---|---|
| `bucket_name` | Nome do bucket S3 para configurar nos backends |
| `dynamodb_table_name` | Nome da tabela DynamoDB para o lock |

## Histórias

| ID | Descrição | Story Points | Estimativa |
|---|---|---|---|
| H-01c | Remote State: S3 Bucket + DynamoDB Lock | 1 (XS) | 6 h |

---
*Password Validator API · Backend Challenge — iti Digital · Junho/2026*
