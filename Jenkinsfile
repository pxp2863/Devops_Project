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
				echo "------------build started------------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
				echo "------------build Completed------------"
            }

        }
		stage('unit test'){
			steps{
			echo "------------unit test started------------"
				sh 'mvn surefire-reports:reports'
				echo "------------unit test completed------------"
			
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
