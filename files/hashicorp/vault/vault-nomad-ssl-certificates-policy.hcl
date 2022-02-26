path "secret/data/ssl-certificates/*" {
  capabilities = ["read"]
}

path "secret/metadata/ssl-certificates/*" {
  capabilities = ["list"]
}
