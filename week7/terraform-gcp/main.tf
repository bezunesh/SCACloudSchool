terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# define provider
provider "google" {
  credentials = file(var.credentials_file)
  project = var.project 
  region  = var.region
  zone    = var.zone 
}

# create a vpc network
resource "google_compute_network" "vpc_network" {
  name = "vpc-network-3"
  auto_create_subnetworks = false
}

# create subnet-us-central-200
resource "google_compute_subnetwork" "public_subnet" {
    name = "subnet-us-central-200"
    ip_cidr_range = "192.168.5.0/24"
    region = "us-central1"
    network = google_compute_network.vpc_network.name
}

# create subnet-us-east-200
resource "google_compute_subnetwork" "private_subnet" {
    name = "subnet-us-east-200"
    ip_cidr_range = "192.168.6.0/24"
    region = "us-east1"
    network = google_compute_network.vpc_network.name
}

# create a public instance
resource "google_compute_instance" "web_server" {
  name         = "web-server-instance"
  machine_type = var.machine_types[var.environment]
  zone = "us-central1-c"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public_subnet.name
    access_config {
    }
  }
}

# create a private instance
resource "google_compute_instance" "backend_server" {
  name         = "backend-server"
  machine_type = var.machine_types[var.environment]
  zone = "us-east1-b"
  tags         = ["backend", "admin"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.private_subnet.name
  }
}

# create a firewall - allow tcp:80
resource "google_compute_firewall" "http" {
  name    = "vpc-network-3-allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["web"]
}

# create a firewall - allow tcp:443
resource "google_compute_firewall" "https" {
  name    = "vpc-network-3-allow-https"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["web"]
}

# create a firewall - allow tcp:ssh
resource "google_compute_firewall" "ssh" {
  name    = "vpc-network-3-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["web", "backend"]
}

# create a router
resource "google_compute_router" "router" {
  name    = "router-1"
  region  = google_compute_subnetwork.private_subnet.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

# create a nat 
resource "google_compute_router_nat" "nat" {
  name                               = "router-1-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}