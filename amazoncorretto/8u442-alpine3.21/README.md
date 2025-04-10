

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

docker buildx build --platform linux/amd64,linux/arm64 --builder mybuilder -t niushuai/amazoncorretto:8u432-alpine3.20 .

使用docker buildx构建镜像
```
docker buildx create --name mybuilder --driver docker-container --use --driver-opt env.http_proxy=172.17.0.1:7890 --driver-opt env.https_proxy=172.17.0.1:7890
docker buildx build --platform linux/amd64,linux/arm64 --builder mybuilder -t niushuai/amazoncorretto:8u432-alpine3.20 --push .
```

buildx create命令里使用的--driver-opt参数是用于指定代理服务器。
buildx build命令里，--push参数是在构建完成后直接推送到镜像仓库里。


linux/amd64

[Setting the timezone](https://wiki.alpinelinux.org/wiki/Setting_the_timezone)

[JDK8安装JCE](https://gist.github.com/enrique-fernandez-polo/44a23b222d0e8abcae7a42152c4a0d93)

[好好学Docker：基于Docker buildx构建多平台镜像](https://www.voidking.com/dev-docker-buildx/)
[docker使用buildx构建多平台镜像如何配置代理进行镜像拉取](https://blog.csdn.net/blake32/article/details/139681251)
## docker镜像导入导出

把镜像导出为tar文件
docker save -o amazoncorretto-8-alpine-jdk-jce.tar amazoncorretto:8-alpine-jdk-jce
从tar文件导入镜像
docker load -i amazoncorretto-8-alpine-jdk-jce.tar


## 问题

### Handler dispatch faled, nested exception is java.lang.NoClassDefFoundError. Could not initialize class sun.awt.X11FontManager

这个问题是在java程序里使用Excel相关的库时会遇到，即使镜像已经安装了FontManager也不行，必须有字体才会正常。
在alpine系统里有[一些可以安装的字体](https://wiki.alpinelinux.org/wiki/Fonts#List_of_available_fonts)
```
apk add --no-cache fontconfig font-dejavu
```
