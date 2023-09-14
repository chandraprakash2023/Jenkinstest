pipeline {
    agent any

    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Retrieve EC2 Public IP') {
            steps {
                script {
                    def awsRegion = 'ap-south-1' // Replace with your AWS region
                    def ec2InstanceId = 'i-0b9816bc51c2dc387' // Replace with your EC2 instance ID

                    def ec2PublicIp = sh(
                        script: "aws ec2 describe-instances --region $awsRegion --instance-ids $ec2InstanceId --query 'Reservations[0].Instances[0].PublicIpAddress' --output text",
                        returnStatus: true
                    ).trim()

                    if (ec2PublicIp) {
                        echo "EC2 Public IP: $3.108.189.102"
                    } else {
                        error "Failed to retrieve EC2 Public IP."
                    }
                }
            }
        }
        stage('Upload to AWS S3') {
            steps {
                // Replace 'your-s3-bucket' and 'your-path' with your specific values
                withAWS(region: 'your-aws-region') {
                    s3Upload(file: 'index.html', bucket: 'codedeploybuckettest123', path: 'var/www/html/index.html')
                }
            }
        }
    }
}

