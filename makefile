TEAM_NAME := davids-dummy-team
REPO_NAME := davids-dummy-app
VERSION := 1.2

COMPONENTS := rails-app content-api worker
ECR := 926803513772.dkr.ecr.eu-west-1.amazonaws.com/$(TEAM_NAME)/$(REPO_NAME)

build-images:
	for component in $(COMPONENTS); do \
		( cd $${component}; docker build -t $(TEAM_NAME)/$(REPO_NAME):$${component} . ); \
	done

tag-images:
	for component in $(COMPONENTS); do \
		docker tag $(TEAM_NAME)/$(REPO_NAME):$${component} $(ECR):$${component}-$(VERSION); \
	done

push-images:
	for component in $(COMPONENTS); do \
		docker push $(ECR):$${component}-$(VERSION); \
	done

build-tag-and-push:
	make build-images
	make tag-images
	make push-images