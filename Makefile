# run alpha application
_run-alpha:
	python3 app-alpha/server.py

# Run beta application with go compiler
_run-beta:
	go run app-beta/main.go

# Compile beta application binaries for linux alpine
compile-beta:
	cd app-beta && GOOS=linux \
		go build -o server.o \
		main.go

# Compile beta application binaries for arm/alpine
compile-beta-arm:
	cd app-beta && GOOS=linux GOARCH=arm GOARM=5 \
		go build -o server.o-arm \
		main.go


# Build alpha container image
build-alpha:
	cd app-alpha && docker build \
		-t ahilaly/app-alpha:v1 .

# Docker build beta image based on golang:1.11
build-beta:
	cd app-beta && docker build \
		-t ahilaly/app-beta:v1 .

# Build beta image with alpine binaries
build-beta-alpine: compile-beta
    # build beta application alpine based image
	cd app-beta && docker build \
		-f Dockerfile.alpine \
		-t ahilaly/app-beta:v1-alpine .

# Build beta image with alpine binaries
build-beta-alpine-arm: compile-beta
    # build beta application alpine based image
	cd app-beta && docker build \
		-f Dockerfile.arm-alpine \
		-t ahilaly/app-beta:v1-alpine-arm64 .

# Run alpha container
run-alpha:
	# run detached container
	docker run -dti -p 8080:8080 ahilaly/app-alpha:v1

# Run beta alpine container
run-beta:
	docker run -dti -p 8081:8081 ahilaly/app-beta:v1-alpine # v1

deploy-redis:
	kubectl create -f kubernetes/redis

docker-compose:
	docker-compose up -d

# Deploy alpha in kubernetes cluster
# kubectl must be configured 
deploy-alpha:
	kubectl create -f kubernetes/alpha

# Deploy beta in kubernetes cluster
deploy-beta:
	kubectl create -f kubernetes/beta


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