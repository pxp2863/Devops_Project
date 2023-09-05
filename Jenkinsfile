pipeline {
    agent {
        node {
            label  "maven"
        }
    }
  environment {
  PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
  } 

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean deploy'
            }
        
	}
      stage('SonarQube analysis') {
      environment {
       scannerHome = tool 'pavan-sonar-scan'
       }
       steps{
    withSonarQubeEnv('sonarqube-server') { 
      sh "${scannerHome}/bin/sonar-scanner"
    }
    }
  }

    }
}

