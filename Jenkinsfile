pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Identify Branch') {
            steps {
                script {
                    if (env.GIT_BRANCH ==~ /origin\/main/) {
                        echo "Main branch detected."
                        BRANCH = "main"
                        DOMAIN = "prod.pavan.today"
                    } else if (env.GIT_BRANCH ==~ /origin\/dev/) {
                        echo "Dev branch detected."
                        BRANCH = "dev"
                        DOMAIN = "dev.pavan.today"
                    } else {
                        echo "Skipping build: only 'main' and 'dev' branches are allowed."
                        currentBuild.result = 'SUCCESS'
                        error("Build aborted.")
                    }
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                script {
                    sh """
                        docker network inspect webnet >/dev/null 2>&1 || docker network create webnet

                        BRANCH_NAME=${BRANCH} \
                        DOMAIN_NAME=${DOMAIN} \
                        docker compose -p socketio-${BRANCH} up -d --build
                    """
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "Checking service at http://${DOMAIN}"
                    sh "curl -s --retry 5 --retry-delay 3 http://${DOMAIN} || echo 'Health check failed'"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline for branch ${env.GIT_BRANCH} completed."
        }
    }
}
