#!/bin/bash

oc extract -n clusters secret/hosted-admin-kubeconfig --to=/root --confirm
oc extract -n clusters secret/hosted-kubeadmin-password --to=/root --confirm

