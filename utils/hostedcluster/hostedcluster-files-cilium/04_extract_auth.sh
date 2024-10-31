#!/bin/bash

mkdir -p /root/clusters/hc-cillium

echo "Admin kubeconfig at:"
oc extract -n clusters secret/hosted-admin-kubeconfig --to=/root/ --confirm

echo "Kubeadmin Password at:"
oc extract -n clusters secret/hosted-kubeadmin-password --to=/root --confirm

