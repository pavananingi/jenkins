pipeline {
    agent any

    environment {
        BRANCH_NAME = "${env.BRANCH_NAME}"
        COMPOSE_PROJECT_NAME = "socketio-${env.BRANCH_NAME}"
        TRAEFIK_NETWORK = "webnet"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate Branch') {
            when {
                not {
                    anyOf {
                        branch 'main'
                        branch 'dev'
                    }
                }
            }
            steps {
                echo "Skipping branch ${env.BRANCH_NAME}. Only 'main' and 'dev' are allowed."
                script {
                    currentBuild.result = 'SUCCESS'
                    error("Aborted.")
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                script {
                    sh """
                        docker network inspect ${TRAEFIK_NETWORK} >/dev/null 2>&1 || docker network create ${TRAEFIK_NETWORK}
                        export BRANCH_NAME=${env.BRANCH_NAME}
                        docker compose -p ${COMPOSE_PROJECT_NAME} up -d --build
                    """
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "Health check for ${env.BRANCH_NAME}"
                    sh 'curl -s --retry 5 --retry-delay 3 http://localhost || echo "Not reachable"'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed for branch ${env.BRANCH_NAME}"
        }
    }
}
