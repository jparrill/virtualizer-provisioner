#!/bin/bash

podman create --name ldap-test -p 10389:10389 -p 10636:10636 ghcr.io/rroemhild/docker-test-openldap:master 
