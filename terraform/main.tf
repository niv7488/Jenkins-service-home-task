# Create the devops namespace
resource "kubernetes_namespace" "devops" {
  metadata {
    name = "devops"
  }
}

# Define a service account for Jenkins
resource "kubernetes_service_account" "jenkins" {
  metadata {
    name = "jenkins"
    namespace = "devops"
  }
}

# Deployment for Jenkins pod
resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = "jenkins"
    namespace = "devops"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.jenkins.metadata.0.name

        container {
          name = "jenkins"
          image = var.jenkins_image
          port {
            container_port = 8080
          }
          resources {
            requests = {
              memory = "1Gi"
              cpu = "1"
            }
            limits = {
              memory = "2Gi"
              cpu = "2"
            }
          }
        }
      }
    }
  }
}

# Service for exposing Jenkins pod
resource "kubernetes_service" "jenkins-service" {
  metadata {
    name = "jenkins-service"
    namespace = "devops"
  }

  spec {
    selector = {
      app = "jenkins"
    }
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }
  }
}

# Output for accessing Jenkins
output "jenkins_url" {
  value = format("http://localhost:${kubernetes_service.jenkins-service.spec.ports[0].node_port}/" )
}
