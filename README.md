# Docker & kubernetes lab


[![CircleCI](https://circleci.com/gh/A-Hilaly/lab-docker-k8s.svg?style=svg)](https://circleci.com/gh/A-Hilaly/lab-docker-k8s)

---

### Requirements
- `docker`

### Commands

Exploring [./Makefile](./Makefile) you'll find rules that for making the following actions:
- Build/Run `alpha` container (Python Flask application) 
- Build/Run `beta` container: (Go application)
- Build/Run `gamma` container: (NodeJS application)
- Build/Run `ruby` container: (Ruby on Rails application)

- Deploy all the applications using `docker-compose`
- Deploy using kubernetes


### Images

Hosted images:
- [alpha](https://cloud.docker.com/repository/docker/supinfosxb/alpha)
- [beta](https://cloud.docker.com/repository/docker/supinfosxb/beta)
- [omega](https://cloud.docker.com/repository/docker/supinfosxb/omega)
- [gamma](https://cloud.docker.com/repository/docker/supinfosxb/gamma)

Pull images
```bash
docker pull supinfosxb/alpha:v1
docker pull supinfosxb/beta:v1-alpine
docker pull supinfosxb/gamma:v1
docker pull supinfosxb/omega:v1
```
