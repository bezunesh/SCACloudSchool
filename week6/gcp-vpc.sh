#!/bin/bash

# create a vpc network
gcloud compute networks create vpc-network-2 \
    --subnet-mode=custom \
    --bgp-routing-mode=regional \
    --mtu=1460

# create the first subnet - public 
gcloud compute networks subnets create subnet-us-east1-100 \
   --network vpc-network-2 \
   --region us-east1 \
   --range 192.168.3.0/24

# create the second subnet - private
gcloud compute networks subnets create subnet-us-central1-100 \
   --network vpc-network-2 \
   --region us-central1 \
   --range 192.168.4.0/24

# create a private instance - backend server
gcloud compute instances create backend-server \
    --image-family debian-10 \
    --image-project debian-cloud \
    --network vpc-network-2 \
    --subnet subnet-us-central1-100 \
    --zone us-central1-a \
    --no-address

# create a public instance - frontend server
gcloud compute instances create frontend-server \
    --image-family debian-10 \
    --image-project debian-cloud \
    --network vpc-network-2 \
    --subnet subnet-us-east1-100 \
    --zone us-east1-b \

# create ssh firewall rule for the network
gcloud compute firewall-rules create vpc-2-allow-ssh \
     --network vpc-network-2 --allow tcp:22

# create http firewall
gcloud compute firewall-rules create vpc-2-allow-http \
     --network vpc-network-2 --allow tcp:80

# create https firewall
gcloud compute firewall-rules create vpc-2-allow-https \
     --network vpc-network-2 --allow tcp:443

# create a cloud router
gcloud compute routers create nat-router \
    --network vpc-network-2 \
    --region us-central1

# create a nat
gcloud compute routers nats create nat-config \
    --router-region us-central1 \
    --router nat-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips
