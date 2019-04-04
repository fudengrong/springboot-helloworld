String buildShell = "${env.buildShell}"
String targetHosts = "${env.targetHosts}"
String targetDir = "${env.targetDir}"
String serviceName = "${env.serviceName}"
String user = "${env.user}"
String port = "${env.port}"

node("master"){
    stage("checkout"){
        checkout scm
    }
    
    stage("build"){
        def mvnHome = tool 'M3'
        sh " ${mvnHome}/bin/mvn ${buildShell} "
        def jarName
        jarName = sh returnStdout: true, script: "cd target && ls *.jar"
        jarName = jarName - "\n"
        sh "mkdir -p /srv/salt/${serviceName} && mv  service.sh target/${jarName} /srv/salt/${serviceName} "
    }
    
    stage("deploy"){
        sh " salt VM_0_12_centos cp.get_file salt://${serviceName}/${jarName}  ${targetDir}/${jarName} mkdirs=True"
        sh " salt VM_0_12_centos cp.get_file salt://${serviceName}/service.sh  ${targetDir}/service.sh mkdirs=True"
        sh " salt VM_0_12_centos cmd.run 'chown ${user}:${user} ${targetDir} -R '"
        sh " salt VM_0_12_centos cmd.run 'su - ${user} -c \"cd ${targetDir} &&  sh service.sh stop\" ' "
        sh " salt VM_0_12_centos cmd.run 'su - ${user} -c \"cd ${targetDir} &&  sh service.sh start ${jarName} ${port} ${targetDir}\" ' "
    }


}
