resource "aws_cloudformation_stack" "DatadogIntegration" {
  name = "DatadogIntegration"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters = {
    APIKey = var.datadog_api_key
    APPKey = var.datadog_application_key
    DatadogSite = var.datadog_region
    InstallLambdaLogForwarder = true
    IAMRoleName = "DatadogIntegrationRole"
    CloudSecurityPostureManagement = false
    DisableMetricCollection = false
  }
  template_url = "https://${module.s3_bucket_for_output_files.s3_bucket_id}.s3.amazonaws.com/datadog_integration_role.yaml"

  lifecycle {
    ignore_changes = [
      parameters["APIKey"],
      parameters["APPKey"]
    ]
  }
}