terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }

  }
}
