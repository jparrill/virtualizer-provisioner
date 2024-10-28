# Virtualizer Provisioner

A series of ansible playbooks and scripts that prepares 1 to N hypervisors to host Openshift under VMs based on QEMU.

## Technologies

- Kcli
- QEMU and KVM
- DNSMasq
- RADvD
- Ansible
- Molecule

## Execution

- Add a new file to the `host_vars` folder which includes the proper configuration.
- Add the new entry in the inventory file called `hosts`
- Make sure you can login into the server via ssh-certificate
- Execute the command

```bash
ansible-playbook -i hosts anygroup.yml
```

You can also execute a concrete part of the playbook

```bash
ansible-playbook -i hosts anygroup.yml --tags kcli
```

## What to do afterwards?

- Go to `/root/baremetal/hub`
- Create a file called `openshift_pull.json` with a valid pull secret
- Modify and place one of the samples to provision a openshift cluster using kcli
- Create a openshift cluster using this command:

```bash
kcli create cluster openshift --pf <KCLI OPENSHIFT CONFIG FILE> --force
```


## Development

By default I've added a new delegated driver to work with orbstack, this will be used by default. The plan is to add a new driver for Libvirtd to do the same in linux

### Test

```
make test
```

### syntax

```
make syntax
```

## ToDo

- Download some binaries
    - termin8
    - oc
    - kubectl
    - oc-mirror

- Add services
    - Minio
    - squid
    - ldap

- Add env file
- Gen ssh key
- Render samples into hub folder

## ToFix
