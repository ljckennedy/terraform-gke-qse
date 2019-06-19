
resource "helm_release" "nfs-server" {
  depends_on = [kubernetes_cluster_role_binding.tiller]
  name       = "nfs-server"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "nfs-server-provisioner"
  #version    = "latest"

  values = [
  <<-EOF

persistence:
  enabled: true
  storageClass: "standard"
  size: 20Gi

service:
  nfsPort: 2049
  mountdPort: 20048
  rpcbindPort: 111

EOF
  ]
}
