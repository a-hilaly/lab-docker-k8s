# Docker & kubernetes lab


[![CircleCI](https://circleci.com/gh/A-Hilaly/lab-docker-k8s.svg?style=svg)](https://circleci.com/gh/A-Hilaly/lab-docker-k8s)

---

### Requirements
- `docker` & `docker-compose`
- Configured `kubectl`
- Golang v1.11 to compile go server


### Commands

Exploring [./Makefile](./Makefile) you'll find rules that for making the following actions:
- Build/Run `app-alpha` container (Python Flask application) 
- Build/Run `app-beta` container: (Go application)
- Deploy using `docker-compose`
- Deploy using kubectl


### Images

Hosted images:
- [app-alpha](https://cloud.docker.com/repository/docker/ahilaly/app-alpha)
- [app-beta](https://cloud.docker.com/repository/docker/ahilaly/app-beta)


Pull images
```bash
docker pull ahilaly/app-alpha:v1
docker pull ahilaly/app-beta:v1-alpine
```
