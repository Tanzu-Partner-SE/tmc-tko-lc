terraform {
  required_providers {
    tanzu-mission-control = {
      source  = "vmware/tanzu-mission-control"
      version = "1.0.3"
    }
  }
}

provider "tanzu-mission-control" {
  # Configuration options
}
