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
				sh 'mvn surefire-report:report'
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

	stage("Quality Gate"){
	steps{
	script{
  timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
    def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
    if (qg.status != 'OK') {
      error "Pipeline aborted due to quality gate failure: ${qg.status}"
    }
  }
}
}
}

	}
}
