stage('Identify Branch') {
    steps {
        script {
            echo "Detected branch: ${env.BRANCH_NAME}"
            
            if (env.BRANCH_NAME == "main") {
                BRANCH = "main"
                DOMAIN = "prod.pavan.today"
                PROJECT = "socket-main"
            } else if (env.BRANCH_NAME == "dev") {
                BRANCH = "dev"
                DOMAIN = "dev.yourdomain.com"
                PROJECT = "socket-dev"
            } else {
                echo "Skipping build: only 'main' and 'dev' branches are allowed."
                currentBuild.result = 'SUCCESS'
                error("Build aborted.")
            }

            // Export to environment if needed later
            env.BRANCH = BRANCH
            env.DOMAIN = DOMAIN
            env.PROJECT = PROJECT
        }
    }
}
