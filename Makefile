_run-alpha:
	# pip3 install -r app-alpha/requirements.txt
	python3 app-alpha/server.py

_run-beta:
	go run app-beta/main.go

compile-beta:
	# Compile beta application binaries for linux alpine
	cd app-beta && GOOS=linux \
		go build -o server.o \
		main.go

build-alpha:
    # build alpha application image
	cd app-alpha && docker build \
		-t ahilaly/app-alpha:v1 .

build-beta:
    # build beta application image
	cd app-beta && docker build \
		-t ahilaly/app-beta:v1 .

build-beta-alpine:
    # build beta application alpine based image
	cd app-beta && docker build \
		-f Dockerfile.alpine \
		-t ahilaly/app-beta:v1-alpine .

run-alpha:
	# run detached container
	docker run -dti -p 8080:8080 ahilaly/app-alpha:v1

run-beta:
	docker run -dti -p 8081:8081 ahilaly/app-beta:v1-alpine # v1

deploy-alpha:
	# deploy alpha application to kubernetes cluster
	# kubectl must be configured 
	kubectl create -f kubernetes/alpha

deploy-beta:
	# deploy beta application to kubernetes cluster
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