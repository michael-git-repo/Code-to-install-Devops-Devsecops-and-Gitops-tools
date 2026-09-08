# Student Enrollment Platform

A learning project for enrolling students with Next.js, TypeScript, Docker, AWS DynamoDB, ECS Fargate, Terraform, and GitHub Actions.

> **Important:** The initial version has no authentication and is for synthetic data only. Do not enter real student information. Before production use, add staff authentication (Amazon Cognito or your identity provider), privacy/retention controls, audit logging, and a legal review.

## Local development

1. Copy `.env.example` to `.env.local`.
2. Install dependencies with `npm install`.
3. Start the app with `npm run dev`.
4. Open `http://localhost:3000`.

By default, records are stored in memory so the app works without AWS. Set `USE_DYNAMODB=true` and provide AWS credentials through your normal AWS profile or OIDC-enabled runtime when using DynamoDB. Never commit credentials or `.env.local`.

## Checks

- `npm run typecheck`
- `npm run lint`
- `npm test`
- `npm run build`
- `docker build -t student-enrollment .`

## Terraform

From `infra/`, run `terraform init`, `terraform fmt`, `terraform validate`, and review `terraform plan`. The starter configuration creates a pay-per-request DynamoDB table, ECR repository, CloudWatch log group, and least-privilege ECS task roles. ECS networking/service resources are the next infrastructure increment.

For shared environments, configure an S3 remote state backend with locking before applying. Do not place AWS access keys in Terraform files or GitHub secrets. Use GitHub Actions OIDC with an IAM trust policy restricted to this repository and deployment branch.

## Cleanup

Run `terraform destroy` from `infra/` after reviewing the plan, then remove the ECR images if needed. Keep synthetic data only.
