pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('Lint Python Code') {
            steps {
                sh 'pylint --disable=R,C,W1203,W1309,E0401 app.py'
            }
        }

        stage('Local Build') {
            steps {
                sh 'docker-compose -f docker-compose.yaml up -d'
            }
        }

        stage('API Tests') {
            steps {
                sh 'pytest tests/test_dbz.py'
            }
        }

        stage('Tag and Push') {
            environment {
                DOCKER_USER = credentials('docker-username')
                DOCKER_PASSWORD = credentials('docker-password')
            }
            steps {
                sh '''
                    docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
                    docker tag dbz-app:latest jtack4970/dbz-app:latest
                    docker push jtack4970/dbz-app:latest
                '''
            }
        }
    }
}
