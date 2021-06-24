provider "google" {
  credentials = "${file("terrafor-pro-3.json")}"
  project = "august-charter-317203"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_container_cluster" "primary" {
  name        = "cluster-1" 
  project     = "august-charter-317203" 
  description = "Demo GKE Cluster"
  location    = "us-central1" 

  remove_default_node_pool = true
  initial_node_count       = 1 

}

resource "google_container_node_pool" "primary_preemptible_node" {
  name       = "node-1"
  project    = "august-charter-317203" 
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
