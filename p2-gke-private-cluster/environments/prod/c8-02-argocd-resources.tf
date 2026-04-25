## Create Name Space for ArgoCD
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

## Helm install ArgoCD

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace_v1.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "9.4.10"

  create_namespace = false

  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer" 
        }
      }
      configs = {
        params = {
          "server.insecure" = true
        }
      }
    })
  ]
}