provider "aws" {
  # Please ensure that you either set the following environment variables
  # AWS_ACCESS_KEY_ID
  # AWS_REGION
  # AWS_SECRET_ACCESS_KEY

  # Or use a shared configuration and credentials file by enabling these variables
  # shared_config_files      = ["~/.aws/conf"]
  # shared_credentials_files = ["~/.aws/creds"]

  # Or enable and set these variables here:
  # region     = "eu-central-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}
