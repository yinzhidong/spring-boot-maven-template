#!/bin/sh


cd /workspaces

if [ ! -d "/workspaces/graalvm-ce-java11-20.3.0" ]; then
#  mkdir /myfolder
  wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
  tar -xzf graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
fi




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




echo -e "export PATH=/workspaces/graalvm-ce-java11-20.3.0/bin:$PATH\nJAVA_HOME=/workspaces/graalvm-ce-java11-20.3.0" >> ~/.bashrc
source ~/.bashrc



java -version
gu install native-image
gu list





#cd /workspaces/spring-boot-maven-template
#native-image -jar /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar java-app
#chmod +x java-app && ./java-app
