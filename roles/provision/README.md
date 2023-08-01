Role Name
=========

Ansible role to prepare the requisites to create a baremetal Openshift cluster

Requirements
------------

- Community modules
- Valid Pull Secret, you need to fill the variable up in the `vars/main.yml` file

Role Variables
--------------

- upstream_dns_01: "IP of the first upstream DNS"
- upstream_dns_02: "IP of the second upstream DNS"
- server_fqdn: "server FQDN for cluster domain purposes"
- ipv6_network: "IPv6 network prefix"
- ipv6_mask: "IPv6 network mask"
- ipv6_network_name: "IPv6 Interface name"
- ipv6_cluster_name: "Openshift cluster name"
- ipv4_network: "IPv4 network prefix"
- ipv4_mask: "IPv4 network mask"
- ipv4_network_name: "IPv4 interface name"
- hosted_cluster_name: "hostedcluster name"

Dependencies
------------

- no dependencies

Example Playbook
----------------

```
- name: Setup hypervisor
  hosts: anygroup
  become: true
  roles:
    - provision
```

License
-------

BSD

Author Information
------------------

This is not a role supported by RedHat.
