skip = true

remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "zed-{{ .Env.CLUSTER }}-terraform-state"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "{{ .Env.REGION }}"
  }
}

terraform {
  extra_arguments "bucket" {
    commands = "${get_terraform_commands_that_need_vars()}"
  }
}

generate "promox_provider" {
  path = "promox_provider.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "proxmox" {
    pm_api_url          = "https://10.10.10.10:8006/api2/json"
    pm_api_token_id     = "zed@pamstrongpassword"
    pm_api_token_secret = "<your-token>"
    pm_tls_insecure     = true
    pm_log_enable       = true
    pm_log_file         = "terraform-plugin-proxmox.log"
    pm_log_levels       = {
        _default    = "debug"
        _capturelog = ""
    }    
}
 
EOF
}

generate "required_providers" {
  path      = "required_providers.tf"
  if_exists = "overwrite_terragrunt"

  contents  = <<EOF
terraform { 
  required_version = ">= 0.14"
 
  required_providers {
    proxmox   = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

EOF
}
