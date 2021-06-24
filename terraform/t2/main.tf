provider "google" {
  credentials = "${file("gcp-terraform.json")}"
  project = "gcp-terraform-317316"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_container_cluster" "primary" {
  name        = "gkecluster" 
  project     = "gcp-terraform-317316" 
  description = "Demo GKE Cluster"
  location    = "us-central1" 

  remove_default_node_pool = true
  initial_node_count       = 1 

}

resource "google_container_node_pool" "primary_preemptible_node" {
  name       = "poolnode"
  project    = "gcp-terraform-317316" 
  location   = "us-central1" 
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium" 

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
