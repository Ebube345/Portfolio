terraform {
  source = "./"
}

# Use local state for bootstrapping
remote_state {
  backend = "local"
  config = {
    path = "terraform.tfstate"
  }
}