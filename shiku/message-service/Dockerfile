FROM centos:7.2.1511
RUN rm -rf /usr/lib/locale/locale-archive
RUN localedef -i zh_CN -f UTF-8 -A /usr/share/locale/locale.alias zh_CN
ENV LANG zh-CN.UTF-8
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ADD yum.conf /etc/yum.conf
RUN yum -y upgrade
RUN yum -y install java-1.8.0-openjdk
RUN yum -y install apr apr-devel apr-util
RUN yum install -y openssl
RUN yum install tomcat-native -y
RUN yum clean all
