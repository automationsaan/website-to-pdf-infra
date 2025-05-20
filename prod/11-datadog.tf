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
    ExternalId = var.datadog_external_id   # <-- # Added datadog_external_id variable needed to set the External ID for the Datadog AWS integration role
  }
  template_url = "https://${module.s3_bucket_for_output_files.s3_bucket_id}.s3.amazonaws.com/datadog_integration_role.yaml"

  lifecycle {
    ignore_changes = [
      parameters["APIKey"],
      parameters["APPKey"]
    ]
  }
}