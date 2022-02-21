PROJECT=ecsFargateApp

help:
	@echo "run-local Run terraform apply to provision the infrastructure"
	@echo "run-plan Run terraform plan to preview the stack"
	@echo "run-destroy Run terraform to destroy the stack"
	@echo "run-build Build docker containers."
	@echo "run-container Run the docker container of this project."
	@echo ""
	@echo "stop-all-containers - Stop all running containers."
	@echo "clear-all-containers - Remove all docker containers."
	@echo "clear-volumes - Remove all docker volumes."
	@echo "clear-images - Remove all docker images."
	@echo "clear-pycache - Remove all __pycache__ folders, will raise errors"


run-local: run-plan
	terraform apply -auto-approve

run-plan:
	terraform init
	terraform plan

run-destroy:
	terraform destroy -auto-approve

run-build:
	docker build -t ecs-practical-app .

run-container: run-build
	docker run -p 5000:5000 -d ecs-practical-app

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

.PHONY: run-local run-plan run-destroy run-build run-container stop-all-containers clear-all-containers clear-volumes clear-images clear-pycache


