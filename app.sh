#!/bin/sh


installGraalvm() {
  cd /workspaces

  if [ ! -d "/workspaces/graalvm-ce-java11-20.3.0" ]; then
  #  mkdir /myfolder
    wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
    tar -xzf graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
  fi
}



makeAliases() {
touch ~/.bash_aliases
source ~/.bash_aliases

cat >~/.bash_aliases<<EOF

alias ll='ls -Alh'
alias cls='clear'


alias gpull='git pull'
alias gpush='git push'
alias gst='git status'
alias gad='git add .'
alias gcm='git commit'
alias gcmedit='git commit --amend'

alias mdt='mvn clean deploy -Dmaven.test.skip=true'
alias mit='mvn clean install -Dmaven.test.skip=true'
alias mpt='mvn clean package -Dmaven.test.skip=true'
alias qcom='mvn clean compile -U -T 1C -Dmaven.test.skip=true -Dmaven.compile.fork=true -DskipDoc=true'
EOF


source ~/.bash_aliases
}


flushBashrc() {
  #source /etc/profile
  source ~/.bashrc
  echo "export PATH=/workspaces/graalvm-ce-java11-20.3.0/bin:$PATH" >> ~/.bashrc
  echo "JAVA_HOME=/workspaces/graalvm-ce-java11-20.3.0" >> ~/.bashrc
  source ~/.bashrc
}


guInstall() {
  java -version
  gu install native-image
  gu list
}


buildJar() {
  cd /workspaces/spring-boot-maven-template
  mvn clean package -Dmaven.test.skip=true
}


copyJar() {
  cp /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar /workspaces/spring-boot-maven-template/app.jar
}




#native-image -jar /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar \
#--no-fallback \
#--initialize-at-build-time=org.springframework.util.unit.DataSize \
#--initialize-at-build-time=org.slf4j.MDC \
#--initialize-at-build-time=ch.qos.logback.classic.Level \
#--initialize-at-build-time=ch.qos.logback.classic.Logger \
#--initialize-at-build-time=ch.qos.logback.core.util.StatusPrinter \
#--initialize-at-build-time=ch.qos.logback.core.status.StatusBase \
#--initialize-at-build-time=ch.qos.logback.core.status.InfoStatus \
#--initialize-at-build-time=ch.qos.logback.core.spi.AppenderAttachableImpl \
#--initialize-at-build-time=org.slf4j.LoggerFactory \
#--initialize-at-build-time=ch.qos.logback.core.util.Loader \
#--initialize-at-build-time=org.slf4j.impl.StaticLoggerBinder \
#--initialize-at-build-time=ch.qos.logback.classic.spi.ThrowableProxy \
#--initialize-at-build-time=ch.qos.logback.core.CoreConstants \
#--report-unsupported-elements-at-runtime \
#--allow-incomplete-classpath \
#-H:+ReportExceptionStackTraces \
#java-app



buildNative() {
   native-image -jar /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar --no-fallback java-app
   chmod +x ./java-app
#   ./java-app
}


#buildImage() {
#  docker build -t yinzhidong/$PROJECT_NAME:v1 .
#}
#
#
#removeContainer() {
#  docker ps | grep "^$PROJECT_NAME" | awk '{print $3}' | xargs docker rm -f
#}
#
#removeImage() {
#  docker images | grep "^$PROJECT_NAME" | awk '{print $3}' | xargs docker rmi -f
#}
#
#
#
#startContainer() {
#  docker run -d -v /home/server/app:/usr/app -p 8001:8000 -e PARAMS=-Dspring.profiles.active=test yinzhidong/$PROJECT_NAME:v1
#}



# 组合函数
# /workspaces/spring-boot-maven-template
# localStorage.setItem("env", "prod")


initEnv() {
  makeAliases
  installGraalvm
  flushBashrc
  guInstall
  buildJar
  buildNative
}





case "$1" in
    'initEnv')
      initEnv
      ;;
  'runApp')
      runApp
      ;;
  'copyJar')
      copyJar
      ;;
  *)
     echo "Usage: app.sh {initEnv | copyJar }"
     exit 1
esac