#
# Output for K8S
#
output "client_certificate" {
  value     = google_container_cluster.gkeqselkn.master_auth[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.gkeqselkn.master_auth[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.gkeqselkn.master_auth[0].cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = google_container_cluster.gkeqselkn.endpoint
  sensitive = true
}


output "run_this" {
  # gcloud container clusters get-credentials terraform-qse-lkn-gke	 --zone us-central1-a --project terraform-qse-lkn  
  value = "  gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.cluster_zone} --project ${var.project}"
}

