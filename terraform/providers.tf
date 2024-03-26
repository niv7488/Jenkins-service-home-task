# Configure the Kubernetes provider
provider "kubernetes" {
  host = "${var.kube_api_server}"
}