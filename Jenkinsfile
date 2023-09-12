pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        AWS_ACCESS_KEY_ID     = credentials('AKIAVCHLF5EKZ4OG4BFM')
        AWS_SECRET_ACCESS_KEY = credentials('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')
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                // Checkout the code from GitHub
                git credentialsId: 'YourGitHubCredentials', url: 'https://github.com/chandraprakash2023/Jenkinstest.git'
            }
        }

        stage('Create Zip Archive') {
            steps {
                // Create a zip archive of your code
                sh 'zip -r my_app.zip ./*'
            }
        }

        stage('Upload to S3') {
            steps {
                // Upload the zip archive to an S3 bucket
                sh "aws s3 cp my_app.zip s3://codedeploybuckettest123/"
            }
        }

        stage('Deploy to EC2 with CodeDeploy') {
            steps {
                // Deploy the code to EC2 using AWS CodeDeploy
                sh "aws deploy create-deployment --application-name Newtest --deployment-group-name TestCodeDeploy --s3-location bucket=codedeploybuckettest123,key=my_app.zip,bundleType=zip"
            }
        }
    }
}



