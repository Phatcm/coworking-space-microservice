output "test_policy_arn" {
  value = module.iam-odic.test_policy_arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}