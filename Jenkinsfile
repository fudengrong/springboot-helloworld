String buildShell = "${env.buildShell}"
String targetHosts = "${env.targetHosts}"
String targetDir = "${env.targetDir}"

node("master"){
    stage("checkout"){
        checkout scm
    }
    
    
    stage("build"){
        sh " mvn ${buildShell} "
        sh " mv  start.sh target/*.jar /srv/salt/${JOB_NAME} "
    }
    
    stage("deploy"){
        sh "sh start.sh stop"
        sh " salt ${targetHosts} cp.get_file salt:// ' ' "
        sh " sh start.sh start "
    }


}
