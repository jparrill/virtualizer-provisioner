mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_path := $(abspath $(patsubst %/,%,$(dir $(mkfile_path))))
provision_path := $(current_path)/roles/provision

all: test syntax

test:
	$(MAKE) -C $(provision_path) converge

destroy:
	$(MAKE) -C $(provision_path) destroy

syntax:
	$(MAKE) -C $(provision_path) syntax

reset:
	$(MAKE) -C $(provision_path) reset