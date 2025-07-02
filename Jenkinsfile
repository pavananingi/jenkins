pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
        timestamps()
    }

    environment {
        COMPOSE_CMD = 'docker compose' // Use 'docker-compose' if using older CLI
    }

    stages {
        stage('Checkout') {
            when { branch 'main' }
            steps {
                echo "🔄 Checking out main branch"
                checkout scm
            }
        }

        stage('Install Dependencies') {
            when { branch 'main' }
            steps {
                echo "📦 Installing npm packages"
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            when { branch 'main' }
            steps {
                echo "🐳 Building Docker image"
                sh "${COMPOSE_CMD} build"
            }
        }

        stage('Deploy Application') {
            when { branch 'main' }
            steps {
                echo "🚀 Deploying app via Docker Compose"
                sh '''
                    ${COMPOSE_CMD} down
                    ${COMPOSE_CMD} up -d --build
                '''
            }
        }
    }

    post {
        success {
            echo "✅ CI/CD pipeline executed successfully on main branch"
        }
        failure {
            echo "❌ CI/CD pipeline failed. Check above logs for issues."
        }
    }
}
