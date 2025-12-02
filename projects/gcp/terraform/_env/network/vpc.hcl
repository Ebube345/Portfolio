/**
  * terragrunt function to create a vpc (with subnets)
*/

terraform {
  source = "tfr:///terraform-google-modules/network/google?version=12.0.0"
  
  # Note: The `?ref=vX.Y.Z` part pins the module to a specific version (highly recommended).
  # We are using the 'modules/vpc' submodule of the network module.
}


inputs = {
  
  # A globally unique name for the VPC network
  #project_id   = local.common_vars.common_project 
  network_name = "ahia-main-vpc"
  
  # Automatically create default routes and firewall rules? 
  # It's recommended to set this to false and define rules explicitly.
  auto_create_subnetworks = false 

  # Define subnets for the VPC (this is required if auto_create_subnetworks is false)
  subnets = [
    {
      subnet_name   = "subnet-us-central1-pub"
      subnet_ip     = "10.10.0.0/20"
      subnet_region = "us-central1"
      subnet_private_access = true
      subnet_flow_logs      = true
      description           = "Public subnet in us-central1"
    },
    {
      subnet_name   = "subnet-us-east4-priv"
      subnet_ip     = "10.20.0.0/20"
      subnet_region = "us-east4"
      subnet_private_access = true
      description           = "Private subnet in us-east4"
    }
  ]

  secondary_ranges = {
      subnet-us-central1-pub = [
          {
              range_name    = "subnet-us-central1-pub-pods-range"
              ip_cidr_range = "10.11.1.0/24"
          },
          {
              range_name    = "subnet-us-central1-pub-services-range"
              ip_cidr_range = "10.11.2.0/24"
          },
      ]

      subnet-us-east4-priv = []
  }

  # Other optional parameters (e.g., routing mode, deletion protection)
  routing_mode        = "REGIONAL"
  delete_default_internet_gateway_routes = true
}
