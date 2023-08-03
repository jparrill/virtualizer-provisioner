mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

all: test syntax

test:
  cd $(current_dir)/roles/provision
  molecule converge

syntax:
  cd $(current_dir)/roles/provision
  molecule syntax
