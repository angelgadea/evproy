provider "google" {
  credentials = "${file("gcp-terraform.json")}"
  project = "gcp-terraform-317316"
  region  = "us-west2"
  zone    = "us-west2-a"
}

resource "google_compute_instance" "instance_1" {
  name         = "terrafom-instance"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params { 
    image = "debian-cloud/debian-9"
    }
  }
  network_interface { 
    network =  "default"
  }
}
