https://github.com/graalvm/graalvm-ce-builds/releases


https://github.com/zeabur/spring-boot-maven-template

https://github.dev/yinzhidong/spring-boot-maven-template


https://yinzhidong-curly-computing-machine-9669jpxg4grfpj4q.github.dev/


https://dash.zeabur.com/projects/641913f5662d5093da1f48fa/services/64191f3b662d5093da1f4974?envID=641913f5783a618d07525b0b


> https://docs.zeabur.com/zh-CN





```shell

vi ~/.bash_aliases

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


source ~/.bash_aliases

```





> https://www.graalvm.org/22.0/docs/getting-started/linux/

```shell

#sudo chown -R root:wheel ./graalvm-ce-java11-22.2.0

# 查看系统加购
# https://blog.csdn.net/weixin_41010198/article/details/109166131

dpkg --print-architecture 
arch


# mac m1
# wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.2.0/graalvm-ce-java11-darwin-aarch64-22.2.0.tar.gz

xattr -r -d com.apple.quarantine /Library/Java/JavaVirtualMachines/graalvm-ce-java11-22.2.0/


#wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.3.1/graalvm-ce-java8-linux-amd64-21.3.1.tar.gz
#wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.0/graalvm-ce-java11-linux-amd64-22.3.0.tar.gz

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz  
tar -xzf graalvm-ce-java11-linux-amd64-20.3.0.tar.gz   



vi ~/.bashrc
export PATH=/workspaces/spring-boot-maven-template/graalvm-ce-java11-20.3.0/bin:$PATH
export JAVA_HOME=/workspaces/spring-boot-maven-template/graalvm-ce-java11-20.3.0

source ~/.bashrc




#安装 native-image
#命令 gu -L install [下载的 native-image 文件路径]

gu install native-image  
gu list



#native-image -jar [jar包全路径] [编译后的文件名称]
native-image -jar /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar java-app

chmod +x java-app && ./java-app

```




```shell

native-image -jar /workspaces/spring-boot-maven-template/target/ZeaburMaven-0.0.1-SNAPSHOT.jar \
--no-fallback \
--initialize-at-build-time=org.springframework.util.unit.DataSize \
--initialize-at-build-time=org.slf4j.MDC \
--initialize-at-build-time=ch.qos.logback.classic.Level \
--initialize-at-build-time=ch.qos.logback.classic.Logger \
--initialize-at-build-time=ch.qos.logback.core.util.StatusPrinter \
--initialize-at-build-time=ch.qos.logback.core.status.StatusBase \
--initialize-at-build-time=ch.qos.logback.core.status.InfoStatus \
--initialize-at-build-time=ch.qos.logback.core.spi.AppenderAttachableImpl \
--initialize-at-build-time=org.slf4j.LoggerFactory \
--initialize-at-build-time=ch.qos.logback.core.util.Loader \
--initialize-at-build-time=org.slf4j.impl.StaticLoggerBinder \
--initialize-at-build-time=ch.qos.logback.classic.spi.ThrowableProxy \
--initialize-at-build-time=ch.qos.logback.core.CoreConstants \
--report-unsupported-elements-at-runtime \
--allow-incomplete-classpath \
-H:+ReportExceptionStackTraces \
java-app


```