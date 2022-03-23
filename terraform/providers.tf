provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "local" {}
