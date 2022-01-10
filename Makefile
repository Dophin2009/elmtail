VARS ?= homelab.tfvars

TESTDIR ?= test

TERRAFORM ?= terraform
TAPPLYFLAGS += -var-file=$(VARS)

.PHONY: init
init	:
	$(TERRAFORM) init

.PHONY: lint
lint	:
	$(TERRAFORM) validate
	$(TERRAFORM) fmt -recursive .

.PHONY: plan
plan	: lint
	$(TERRAFORM) plan $(TAPPLYFLAGS)

.PHONY: apply
apply	: lint
	$(TERRAFORM) apply $(TAPPLYFLAGS)

.PHONY : destroy
destroy : lint
	$(TERRAFORM) destroy

.PHONY : test-init
test-init :
	$(TERRAFORM) -chdir=$(TESTDIR) init

.PHONY : test-lint
test-lint :
	$(TERRAFORM) -chdir=$(TESTDIR) validate
	$(TERRAFORM) -chdir=$(TESTDIR) fmt -recursive .

.PHONY : test-plan
test-plan : test-lint
	$(TERRAFORM) -chdir=$(TESTDIR) plan

.PHONY : test-apply
test-apply : test-lint
	$(TERRAFORM) -chdir=$(TESTDIR) apply

.PHONY : test-destroy
test-destroy : test-lint
	$(TERRAFORM) -chdir=$(TESTDIR) destroy
