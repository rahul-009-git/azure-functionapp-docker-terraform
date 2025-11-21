pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('azure-client-id')
        ARM_CLIENT_SECRET   = credentials('azure-client-secret')
        ARM_SUBSCRIPTION_ID = credentials('azure-subscription-id')
        ARM_TENANT_ID       = credentials('azure-tenant-id')
    }

    parameters 
    { 
        booleanParam( 
            name: 'APPLY', 
            defaultValue: false, 
            description: 'Enable to apply infra changes' ) 
    }

    stages {
        stage("checkout") {
            steps {
                checkout scm 
            }
        }

        stage ("terraform init") {
            steps {
                sh 'terraform init'
            }
        }

        stage ("terraform plan") {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') 
            { 
                when {
                 expression { return params.APPLY == true } 
                } 
                 
                 steps { sh 'terraform apply -auto-approve tfplan' }
            
            }
    }

    

    post {
        success {
            echo "Terraform executed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}