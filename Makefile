VARS ?= homelab.tfvars

TERRAFORM ?= terraform
TAPPLYFLAGS += -var-file=$(VARS)

.PHONY: init
init:
	$(TERRAFORM) init

.PHONY: apply
apply: lint
	$(TERRAFORM) apply $(TAPPLYFLAGS)

.PHONY: plan
plan: lint
	$(TERRAFORM) plan $(TAPPLYFLAGS)

.PHONY: lint
lint:
	$(TERRAFORM) validate
	$(TERRAFORM) fmt -recursive .
