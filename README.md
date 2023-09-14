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
### Test

```
cd roles/provision
molecule converge
```