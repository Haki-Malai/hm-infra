# Backend Bootstrap

Run these once from a trusted workstation with valid AWS credentials.

```sh
aws sts get-caller-identity

aws s3api create-bucket \
  --bucket hm-infra-tfstate-haki-malai-us-east-1 \
  --region us-east-1

aws s3api put-bucket-versioning \
  --bucket hm-infra-tfstate-haki-malai-us-east-1 \
  --versioning-configuration Status=Enabled

aws s3api put-public-access-block \
  --bucket hm-infra-tfstate-haki-malai-us-east-1 \
  --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

aws s3api put-bucket-encryption \
  --bucket hm-infra-tfstate-haki-malai-us-east-1 \
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

aws dynamodb create-table \
  --table-name hm-infra-tf-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

Then create an IAM user or role for GitHub Actions using
`backend/github-actions-iam-policy.json`.
