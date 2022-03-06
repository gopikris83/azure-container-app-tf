PROJECT=azureContainerApp

help:
	@echo "run-remote-backend Run to create a remote backend storage for tf state creation in resource group"
	@echo "run-apply Run terraform apply to provision the infrastructure"
	@echo "run-push Tag docker images and push the image to Azure ACR"
	@echo "run-plan Run terraform plan to preview the stack"
	@echo "run-build Build docker containers."
	@echo "run-push Push the docker images to Azure Container registry"
	@echo "run-container Run the docker container of this project."
	@echo "run-destroy Run terraform to destroy the stack"
	@echo ""
	@echo "stop-all-containers - Stop all running containers."
	@echo "clear-all-containers - Remove all docker containers."
	@echo "clear-volumes - Remove all docker volumes."
	@echo "clear-images - Remove all docker images."
	@echo "clear-pycache - Remove all __pycache__ folders, will raise errors"


run-remote-backend:
	sh remote_backend_script.sh

run-apply:
	terraform apply -auto-approve

run-plan:
	terraform init
	terraform plan

run-build:
	docker build -t ecs-practical-app .

run-container: run-build
	docker run -p 5000:5000 -d ecs-practical-app

run-push:
	docker tag ecs-practical-app:latest azacr1202.azurecr.io/azcontainerapp:latest
	docker push azacr1202.azurecr.io/azcontainerapp:latest

run-destroy:
	terraform destroy -auto-approve

stop-all-containers:
	docker ps -q | xargs -I@ docker stop @

clear-all-containers: stop-all-containers
	docker ps -aq | xargs -I@ docker rm @

clear-volumes: clear-all-containers
	docker volume ls -q | xargs -I@ docker volume rm @

clear-images: clear-all-containers clear-volumes
	docker images -q | uniq | xargs -I@ docker rmi -f @

clear-pycache:
	sudo find . -name "__pycache__" -exec rm -rf {} \;

.PHONY: run-remote-backend run-apply run-plan run-destroy run-build run-container stop-all-containers clear-all-containers clear-volumes clear-images clear-pycache


