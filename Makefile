########################################################
# Alpha: python server

# python deps
_deps-alpha:
	pip3 install -r alpha/requirements.txt

# Run alpha application
_run-alpha:
	python3 alpha/server.py

# Build alpha container image
build-alpha:
	cd alpha && docker build \
		-t ahilaly/alpha:v1 .

# Run alpha container
run-alpha:
	# run detached container
	docker run -dti -p 8080:8080 ahilaly/alpha:v1

# Deploy alpha in kubernetes cluster
# kubectl must be configured 
deploy-alpha:
	kubectl create -f kubernetes/alpha

########################################################
# Beta: Go server

# Run beta application with go compiler
_run-beta:
	go run beta/main.go

# Compile beta application binaries for linux alpine
compile-beta:
	cd beta && GOOS=linux \
		go build -o server.o \
		main.go

# Compile beta application binaries for arm/alpine
compile-beta-arm:
	cd beta && GOOS=linux GOARCH=arm GOARM=5 \
		go build -o server.o-arm \
		main.go


# Docker build beta image based on golang:1.11
build-beta:
	cd beta && docker build \
		-t ahilaly/beta:v1 .

# Build beta image with alpine binaries
build-beta-alpine: compile-beta
    # build beta application alpine based image
	cd beta && docker build \
		-f Dockerfile.alpine \
		-t ahilaly/beta:v1-alpine .

# Build beta image with alpine binaries
build-beta-alpine-arm: compile-beta
    # build beta application alpine based image
	cd beta && docker build \
		-f Dockerfile.arm-alpine \
		-t ahilaly/beta:v1-alpine-arm64 .

# Run beta alpine container
run-beta:
	docker run -dti -p 8081:8081 ahilaly/beta:v1-alpine # v1

# Deploy beta in kubernetes cluster
deploy-beta:
	kubectl create -f kubernetes/beta

########################################################
# Omega: ruby rails server

# python deps
_deps-omega:
	gem install rails bundler && bundle update

# Run omega application
_run-omega:
	cd omega && rails server

# Build omega container image
build-omega:
	cd omega && docker build \
		-t ahilaly/omega:v1 .

# Run omega container
run-omega:
	# run detached container
	docker run -it -p 80:3000 ahilaly/omega:v1

# Deploy omega in kubernetes cluster
# kubectl must be configured 
deploy-omega:
	kubectl create -f .kubernetes/omega


########################################################
# Extra

deploy-redis:
	kubectl create -f kubernetes/redis

docker-compose:
	docker-compose up -d


# kubectl
# get pod logs: kubectl logs pod-name
# scale deployment: kubectl scale deployment dep-name --replicas=10
# k get pods: kubectl get pods [-n --namespace string]
# k get services: kubectl get service [-n --namespace string]

clear-cluster:
	# delete all deployments
	kubectl delete deployment --all
	# delete all services
	kubectl delete service --all

# docker-compose
# compose: docker-compose up-d (detached)
# compose-down: docker-compose down
# compose-logs: docker-compose logs
