# Cloud DevOps Engineer Capstone Project

This project is the final project of the Cloud DevOps Engineer Udacity Nanodegree. The project showcases all skills and knowledge acquired throughout the Cloud DevOps Nanodegree program which included:

* Provisioning network resources in AWS with CloudFormation / Ansible
* Containerizing applications with Docker
* Building CI/CD pipelines with Jenkins / CircleCI
* Building and deploying microservices in a Kubernetes cluster

#### Table of Contents
1. [Setup a Local Deployment](#setup-a-local-deployment)
    1. Python virtual Environment
    2. Local Docker Deployment
    3. Local Kubernetes Deployment
2. Setup an AWS deployment
    1. Provision Network Resources
    2. Setup Rolling Kubernetes Deployment
    3. Ansible Deployment
    
## Setup a Local Deployment

__Requirements__
* Install Python 3.7
* Install Docker
* Install Kubernetes (either via Docker Desktop or minikube)

### Python Virtual Environment
1. Clone the repository:
    ```bash
    git clone https://github.com/spider-sauce/cloud-devops-capstone.git
    ```

2. Setup `venv`:

    ```bash
    python -m venv ~/.devops
    source ~/.devops/bin/activate
    ```

3. Run `make install && make lint`