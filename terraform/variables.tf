# Define a variable for the Jenkins image
variable "jenkins_image" {
  default = "jenkins/jenkins:lts"
}

variable "kube_api_server" {
  default = ""
}