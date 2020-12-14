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
                sh 'docker-compose -f docker-compose.yml up -d'
            }
        }

        stage('API Tests') {
            steps {
                sh 'pytest tests/test_dbz.py'
            }
        }

        stage('Tag and Push') {
            steps {
                sh '''
                    docker tag dbz-app:latest jtack4970/dbz-app:latest
                    docker push jtack4970/dbz-app:latest
                '''
            }
        }
    }
}