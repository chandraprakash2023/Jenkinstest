pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/chandraprakash2023/Jenkinstest.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install' // or any build command you usee
            }
        }

        stage('Zip') {
            steps {
                sh 'zip -r my-app.zip target/*' // or any command to zip your code
            }
        }

        stage('Upload to S3') {
            steps {
                withAWS(credentials: 'aws-credentials') { // configure AWS credentials in Jenkins
                    sh 'aws s3 cp my-app.zip s3://codedeploybuckettest123/' // replace with your S3 bucket name
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                withAWS(credentials: 'aws-credentials') { // configure AWS credentials in Jenkins
                    sh 'aws deploy create-deployment --application-name Newtest --s3-location bucket=codedeploybuckettest123,bundleType=zip,key=my-app.zip' // replace with your application and S3 details
                }
            }
        }
    }
}
