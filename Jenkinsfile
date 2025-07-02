pipeline {
    agent any

    environment {
        TRAEFIK_NETWORK = "traefik"
        COMPOSE_PROJECT_NAME = "myproject-${env.BRANCH_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Branch Check') {
            when {
                not {
                    anyOf {
                        branch 'main'
                        branch 'dev'
                    }
                }
            }
            steps {
                echo "Skipping pipeline for branch ${env.BRANCH_NAME}."
                script {
                    currentBuild.result = 'SUCCESS'
                    error("Build stopped: not main or dev branch.")
                }
            }
        }

        stage('Prepare Environment') {
            when {
                anyOf {
                    branch 'main'
                    branch 'dev'
                }
            }
            steps {
                script {
                    sh 'mkdir -p traefik && touch traefik/acme.json && chmod 600 traefik/acme.json'
                }
            }
        }

        stage('Docker Compose Up') {
            when {
                anyOf {
                    branch 'main'
                    branch 'dev'
                }
            }
            steps {
                script {
                    sh """
                        docker network inspect $TRAEFIK_NETWORK >/dev/null 2>&1 || docker network create $TRAEFIK_NETWORK
                        docker compose -p $COMPOSE_PROJECT_NAME up -d --build
                    """
                }
            }
        }

        stage('Health Check') {
            when {
                anyOf {
                    branch 'main'
                    branch 'dev'
                }
            }
            steps {
                script {
                    echo "Running health checks..."
                    sh 'curl -s --retry 5 --retry-delay 3 http://localhost || echo "Service not responding"'
                }
            }
        }

        stage('Post-Deploy Actions') {
            when {
                branch 'main'
            }
            steps {
                echo "Performing main branch-specific actions (e.g., tagging, notifications, etc.)"
            }
        }
    }

    post {
        always {
            echo "Pipeline for branch '${env.BRANCH_NAME}' finished with result: ${currentBuild.currentResult}"
        }
    }
}

