

https://cdn-thirdparty.starrocks.com/java-se-8u41-ri.tar.gz



用这个命令让容器一直运行，方便进容器调试命令
docker run -it -d -v /etc/localtime:/etc/localtime --rm amazoncorretto:test tail -f /dev/null

在线方式
``` Dockerfile
FROM amazoncorretto:8u432-alpine3.20

RUN wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" -O jce_policy-8.zip && \
    unzip -qo jce_policy-8.zip && \
    cp UnlimitedJCEPolicyJDK8/US_export_policy.jar ${JAVA_HOME}/jre/lib/security/US_export_policy.jar && \
    cp UnlimitedJCEPolicyJDK8/local_policy.jar ${JAVA_HOME}/jre/lib/security/local_policy.jar && \
    rm -rf jce_policy-8.zip && \
    rm -rf UnlimitedJCEPolicyJDK8 && \
    wget -q "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk18on/1.79/bcprov-jdk18on-1.79.jar" -O ${JAVA_HOME}/jre/lib/ext/bcprov-jdk18on-1.79.jar && \
    sed -i '/security.provider.9=sun.security.smartcardio.SunPCSC/a\security.provider.10=org.bouncycastle.jce.provider.BouncyCastleProvider' ${JAVA_HOME}/jre/lib/security/java.security && \
    apk add --no-cache tzdata
```

docker build -t amazoncorretto:8u432-alpine3.20-jce .


[Setting the timezone](https://wiki.alpinelinux.org/wiki/Setting_the_timezone)

[JDK8安装JCE](https://gist.github.com/enrique-fernandez-polo/44a23b222d0e8abcae7a42152c4a0d93)


## docker镜像导入导出

把镜像导出为tar文件
docker save -o amazoncorretto-8-alpine-jdk-jce.tar amazoncorretto:8-alpine-jdk-jce
从tar文件导入镜像
docker load -i amazoncorretto-8-alpine-jdk-jce.tar

