TERRAFORM ?= terraform

.PHONY: init
init:
	$(TERRAFORM) init

.PHONY: apply
apply: lint
	$(TERRAFORM) apply

.PHONY: plan
plan: lint
	$(TERRAFORM) plan

.PHONY: lint
lint:
	$(TERRAFORM) validate
	$(TERRAFORM) fmt -recursive .
