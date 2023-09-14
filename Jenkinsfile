pipeline {
    agent any

    environment {
        EC2_PUBLIC_IP = '3.108.189.102'
    }

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

                    // Use the AWS credentials you configured in Jenkins
                    withAWS(credentials: 'AWS', region: awsRegion) {
                        EC2_PUBLIC_IP = sh(
                            script: "aws ec2 describe-instances --region $awsRegion --instance-ids $ec2InstanceId --query 'Reservations[0].Instances[0].PublicIpAddress' --output text",
                            returnStdout: true
                        ).trim()

                        if (EC2_PUBLIC_IP) {
                            echo "EC2 Public IP: $EC2_PUBLIC_IP"
                        } else {
                            error "Failed to retrieve EC2 Public IP."
                        }
                    }
                }
            }
        }
        stage('Upload to AWS S3') {
            steps {
                script {
                    def awsRegion = 'ap-south-1' // Replace with your AWS region
                    def s3Bucket = 'codedeploybuckettest123'
                    def s3Path = 'var/www/html/index.html'

                    def s3Object = [
                        entries: [
                            [
                                file: 'index.html',
                                path: s3Path
                            ]
                        ],
                        bucket: s3Bucket
                    ]

                    // Use the AWS credentials you configured in Jenkins
                    withAWS(credentials: 'AWS', region: awsRegion) {
                        if (EC2_PUBLIC_IP) {
                            echo "Uploading to EC2 Public IP: $EC2_PUBLIC_IP"
                            // You can use the EC2_PUBLIC_IP variable here
                            // to upload to the correct EC2 instance.
                        } else {
                            error "EC2 Public IP not available. Cannot upload to S3."
                        }
                    }
                }
            }
        }
    }
}
