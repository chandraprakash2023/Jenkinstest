def latestTag = 'UnKnown1'
@Library('github.com/releaseworks/jenkinslib') _
pipeline {
     environment {
        BRANCH_NAME = "dev"
        MAJOR_VERSION = "1"
        MINOR_VERSION = "0"
        GIT_REPO = "https://github.com/chandraprakash2023/Jenkinstest.git"

    }
    agent any
    stages {
          stage('SonarQube analysis')
          {
        steps {
            sh "echo woith sona start"

        //     script {

        //   scannerHome = tool 'nx-scanner'
        // }
        //  sh "echo woith sona r 1${scannerHome}"
        // withSonarQubeEnv('SonarCloud') {
        //     sh "echo woith sonar ${scannerHome}"
        //   sh "${scannerHome}/bin/sonar-scanner"

        // } 

        }
      }
        stage('Build') {

            steps {
                  {
                                    sh 'install_dependencies.sh'
                                    sh 'start_server.sh'
                                    sh ''
                                    echo 'code building done'
                                }
                }
        }


       stages {
        stage('Checkout') {
            steps {
                // Checkout your code from Bitbucket repository
                script {
                    checkout([$class: 'GitSCM', branches: [[name: 'main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'your-credentials-id', url: 'https://github.com/chandraprakash2023/Jenkinstest.git']]])
                }
            }
        }
        
        stage('Create Zip') {
            steps {
                // Create a zip file containing the checked-out code
                script {
                    sh 'zip -r my_code.zip ./*'
                }
                
         stage('Upload Build') {
            steps {
                echo "pusing latest zip to s3 bucket"
                withAWS(credentials:'aws-credentials',region: 'ap-south-1') {
                    script{
                       s3Upload(file:sh(returnStdout: true, script: 'printf $(git describe --abbrev=0 --tags).zip'), bucket:'nx-client-code-deploy', path:sh(returnStdout: true, script: 'printf $(git describe --abbrev=0 --tags).zip'))
                    }
                }
            }
        }
         stage('deploy') {
           steps {
               withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'accessKey', passwordVariable: 'secretKey')]) {
              step([$class: 'AWSCodeDeployPublisher',
              applicationName: 'nxClientFontEnd',  credentials: 'awsAccessKey',
              awsAccessKey: "$accessKey", awsSecretKey: "$secretKey",
              deploymentGroupAppspec: true, deploymentGroupName: 'dev_env', deploymentMethod: 'deploy',
               excludes: '', iamRoleArn: 'arn:aws:iam::844556987140:instance-profile/EC2-instance', includes: '**', proxyHost: '', proxyPort: 0,
               region: 'ap-south-1', s3bucket: 'nx-client-code-deploy', s3prefix: '', subdirectory: '', versionFileName: '$(git describe --abbrev=0 --tags).zip',
                waitForCompletion: false])
                }


            }
        }

    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'Project build was completed'
        }
        failure {
            echo 'Project build was failed'
        }
        // unstable {
        //     echo 'This will run only if the run was marked as unstable'
        // }
        changed {
            echo 'This will run only if the state of the Pipeline has changed new chage'
            echo 'For example, if the Pipeline was previously failing but is now successfully done'
        }
    }
}
