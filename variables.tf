#
# Variables
#
variable "project" {
}

variable "region" {
  default = "us-central1"
}
variable "network" {
  default = "us-central1"
}

variable "cluster_name" {
  default = "terraform-qse-gke"
}

variable "cluster_zone" {
  default = "us-central1-a"
}

variable "cluster_k8s_version" {
  default = "1.13.6-gke.6"
}

variable "initial_node_count" {
  default = 2
}

variable "autoscaling_min_node_count" {
  default = 1
}

variable "autoscaling_max_node_count" {
  default = 3
}

variable "disk_size_gb" {
  default = 40
}

variable "disk_type" {
  default = "pd-standard"
}

variable "machine_type" {
  default = "n1-standard-2"
}

