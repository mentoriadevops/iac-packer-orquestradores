SHELL	 = /bin/bash

cnf ?= .env

ifneq ($(shell test -e $(cnf) && echo -n yes),yes)
	ERROR := $(error $(cnf) file not defined in current directory)
endif

include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

ifneq ($(shell test -e $(INCLUDE_MAKEFILE) && echo -n yes),yes)
	ifdef REMOTE_MAKEFILE
		REMOTE_MAKEFILE_RESULT := $(shell curl ${REMOTE_MAKEFILE} -o ${INCLUDE_MAKEFILE})
	else
		ERROR := $(error REMOTE_MAKEFILE not provided, look for your .env file)
	endif
endif

ifdef INCLUDE_MAKEFILE
	include ${INCLUDE_MAKEFILE}	
endif

packer-init: ## Executar comando 'packer init'
	cd packer ; \
		docker run \
			--rm \
			-v $$PWD:/workspace \
			-w /workspace \
			-it \
			-e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
			$(DOCKER_IMAGE) \
			init .

packer-fmt: ## Executar comando 'packer fmt'
	cd packer ; \
		docker run \
			--rm \
			-v $$PWD:/workspace \
			-w /workspace \
			-it \
			-e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
			$(DOCKER_IMAGE) \
			fmt .

packer-validate: ## Executar comando 'packer validate'
	cd packer ; \
		docker run \
			--rm \
			-v $$PWD:/workspace \
			-w /workspace \
			-it \
			-e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
			$(DOCKER_IMAGE) \
			validate .

packer-build: ## Executar comando 'packer build'
	docker run \
		--rm \
		-v $$PWD:/workspace \
		-w /workspace \
		-it \
		--env-file $$PWD/.env \
		-e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
		$(DOCKER_IMAGE) build packer/

auth-create-sa: ## 1: create sa
	gcloud iam service-accounts create ${GCP_PACKER_SA} \
		--project ${GCP_PROJECT} \
		--description="Packer Service Account" \
		--display-name="Packer Service Account"

auth-create-iam-policy: ## 2: create policy
	gcloud projects add-iam-policy-binding ${GCP_PROJECT} \
    --member=serviceAccount:${GCP_PACKER_SA}@${GCP_PROJECT}.iam.gserviceaccount.com \
    --role=roles/compute.instanceAdmin.v1

auth-create-add-policy: ## 3: add policy
	gcloud projects add-iam-policy-binding ${GCP_PROJECT} \
    --member=serviceAccount:${GCP_PACKER_SA}@${GCP_PROJECT}.iam.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser

auth-create-creds-file: ## 4: generate creds file
	gcloud iam service-accounts \
		keys create creds.json \
		--iam-account=${GCP_PACKER_SA}@${GCP_PROJECT}.iam.gserviceaccount.com

generate-credentials: auth-create-sa auth-create-iam-policy auth-create-add-policy auth-create-creds-file ## generate file to creatential gcp

build: packer-init packer-validate packer-build ## build image with packer
