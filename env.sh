#!/bin/sh


cd /workspaces

if [ ! -d "/workspaces/graalvm-ce-java11-20.3.0" ]; then
#  mkdir /myfolder
  wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
  tar -xzf graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
fi


touch ~/.bash_aliases

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



#source /etc/profile

echo "export PATH=/workspaces/graalvm-ce-java11-20.3.0/bin:$PATH" >> ~/.bashrc
echo "JAVA_HOME=/workspaces/graalvm-ce-java11-20.3.0" >> ~/.bashrc
source ~/.bashrc



java -version
gu install native-image
gu list





#cd /workspaces/spring-boot-maven-template
# mvn clean package -Dmaven.test.skip=true
# native-image -jar /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar java-app
# chmod +x java-app && ./java-app



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