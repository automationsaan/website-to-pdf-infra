resource "aws_cloudformation_stack" "DatadogIntegration" {
  name = "DatadogIntegration"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters = {
    ExternalId = var.datadog_external_id
    IAMRoleName = "DatadogIntegrationRole"
    # Optionally add these if you want to override defaults:
    # BasePermissions = "Full"
    # LogArchives = ""
    # CloudTrails = ""
    # CloudSecurityPostureManagementPermissions = false
  }
  template_url = "https://datadog-cloudformation-template-quickstart.s3.amazonaws.com/aws/main_v2.yaml"

  lifecycle {
    ignore_changes = [
      parameters["ExternalId"],
      parameters["IAMRoleName"]
    ]
  }
}