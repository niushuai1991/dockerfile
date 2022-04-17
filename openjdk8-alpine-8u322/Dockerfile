FROM eclipse-temurin:8u322-b06-jdk-alpine

LABEL author=niushuai

# 添加环境变量
ARG CLASSPATH=".:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar"
ARG PATH="$PATH:$JAVA_HOME/bin"

# 安装curl,busybox（包含telnet),bash
RUN apk update && apk add curl && apk add busybox-extras && apk add drill && apk add bash && apk add bash-completion

# 启用bcprov，解决openjdk不能正常请求https的问题
RUN cd $JAVA_HOME/jre/lib/ext/ && \
    wget https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar && \
    cd $JAVA_HOME/jre/lib/security/ && \
    sed -i 76a\security.provider.10=org.bouncycastle.jce.provider.BouncyCastleProvider java.security

# 安装skywalking-agent
COPY agent_8.1.0 /usr/local/agent_8.1.0

ENTRYPOINT [ "/bin/bash" ]