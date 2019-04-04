String buildShell = "${env.buildShell}"
String targetHosts = "${env.targetHosts}"
String targetDir = "${env.targetDir}"

node("master"){
    stage("checkout"){
        checkout scm
    }
    
    
    stage("build"){
        sh " mvn clean install -DskipTests "
        sh " mv  service.sh target/*.jar /srv/salt/${JOB_NAME} "
    }
    
    stage("deploy"){
        sh " salt VM_0_12_centos cp.get_file salt://test/helloworld-0.0.1-SNAPSHOT.jar  /opt/javatest/helloworld-0.0.1-SNAPSHOT.jar mkdirs=True"
        sh " salt VM_0_12_centos cp.get_file salt://test/service.sh  /opt/javatest/service.sh mkdirs=True"
        sh " salt VM_0_12_centos cmd.run 'chown tomcat:tomcat /opt/javatest -R '"
        sh " salt VM_0_12_centos cmd.run 'su - tomcat -c \"cd /opt/javatest &&  sh service.sh stop\" ' "
        sh " salt VM_0_12_centos cmd.run 'su - tomcat -c \"cd /opt/javatest &&  sh service.sh start\" ' "
    }


}
