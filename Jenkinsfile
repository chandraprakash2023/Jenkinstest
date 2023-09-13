pipeline {
    agent any

    stages {
        stage('Deploy to EC2') {
            steps {
                script {
                        def EC2_INSTANCE_ID = 'i-0b9816bc51c2dc387'
                        def EC2_AZ = 'ap-south-1'

            sh '''
                sudo apt install apache2 -y
                sed -i -e 's/was deployed/was deployed on $EC2_INSTANCE_ID in $EC2_AZ/g' /var/www/html/index.html
                chmod 664 /var/www/html/index.html
                sudo service apache2 start
            '''
        }
            }
        }
        stage('Verify Webpage') {
            steps {
                script {
                    def curlOutput = sh(script: 'curl -v --silent localhost:80 2>&1', returnStatus: true)
                    if (curlOutput == 0) {
                        echo "Webpage successfully accessed."
                    } else {
                        error "Failed to access webpage."
                    }
                }
            }
        }
    }
}
