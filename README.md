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

```bash
ansible-playbook -i hosts anygroup.yml
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