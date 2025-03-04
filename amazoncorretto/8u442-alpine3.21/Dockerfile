FROM amazoncorretto:8u442-alpine3.21

RUN wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" -O jce_policy-8.zip && \
    unzip -qo jce_policy-8.zip && \
    cp UnlimitedJCEPolicyJDK8/US_export_policy.jar ${JAVA_HOME}/jre/lib/security/US_export_policy.jar && \
    cp UnlimitedJCEPolicyJDK8/local_policy.jar ${JAVA_HOME}/jre/lib/security/local_policy.jar && \
    rm -rf jce_policy-8.zip && \
    rm -rf UnlimitedJCEPolicyJDK8 && \
    wget -q "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk18on/1.79/bcprov-jdk18on-1.79.jar" -O ${JAVA_HOME}/jre/lib/ext/bcprov-jdk18on-1.79.jar && \
    sed -i '/security.provider.9=sun.security.smartcardio.SunPCSC/a\security.provider.10=org.bouncycastle.jce.provider.BouncyCastleProvider' ${JAVA_HOME}/jre/lib/security/java.security && \
    apk add --no-cache fontconfig && \
    apk cache clean