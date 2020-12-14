# Cloud DevOps Engineer Capstone Project

This project is the final project of the Cloud DevOps Engineer Udacity Nanodegree. The project showcases all skills and knowledge acquired throughout the Cloud DevOps Nanodegree program which included:

* Provisioning network resources in AWS with CloudFormation / Ansible
* Containerizing applications with Docker
* Building CI/CD pipelines with Jenkins / CircleCI
* Building and deploying microservices in a Kubernetes cluster

#### Table of Contents
1. [Setup a Local Deployment](#setup-a-local-deployment)
    1. [Python virtual Environment](#python-virtual-environment)
    2. [Local Docker Deployment](#local-docker-deployment)
    3. Local Kubernetes Deployment #TODO
2. Setup an AWS deployment #TODO 
    1. Provision Network Resources #TODO
    2. Setup Rolling Kubernetes Deployment #TODO
    3. Ansible Deployment #TODO
    
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
    python -m venv ~/.capstone
    source ~/.capstone/bin/activate
    ```

3. Run `make install && make lint`
4. Download and [run the `mongod` service](https://docs.mongodb.com/guides/server/install/)
5. Run `python app.py` to run the flask app.
6. Test the app stack:
    > These examples use [cURL](https://curl.se/)
    
    ```bash
    # Test the app
    curl http://localhost:5000/dbz
    
    # Insert data
    curl -v -X POST -H "Content-type: application/json" -d \
    '{"name":"Goku", "powerlevel": 150,000,000}' \
    'http://localhost:5000/dbz'
    
    # Test the record
    curl http://localhost:5000/dbz/Goku 
    ```

### Local Docker Deployment

1. Install [Docker Compose](https://docs.docker.com/compose/install/).
2. Launch the app stack: `docker-compose -f docker-compose.yml up -d`
3. Ensure the containers deployed and are running:
    
    ```bash
    cloud-devops-capstone % docker ps
    CONTAINER ID   IMAGE            COMMAND                  CREATED       STATUS       PORTS                      NAMES
    ada25e53f6dd   dbz-app:latest   "python app.py"          6 hours ago   Up 6 hours   0.0.0.0:5000->5000/tcp     dbz-app
    a1c987fe96b4   mongo:latest     "docker-entrypoint.s…"   6 hours ago   Up 6 hours   0.0.0.0:27017->27017/tcp   mongodb
    ```
4. Test the app stack (see step 6 in [local python deployment](#python-virtual-environment))