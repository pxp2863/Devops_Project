def registry = 'https://pallagani.jfrog.io'
def imageName = 'pallagani.jfrog.io/docker-local/ttrend'
def version   = '2.1.4'
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
           stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-cred"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }

	}
}
