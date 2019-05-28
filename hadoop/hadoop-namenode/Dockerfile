FROM uhopper/hadoop-namenode:latest

MAINTAINER niushuai(guisu2010@gmail.com)

ENV HIVE_VERSION 2.3.4
ENV HIVE_HOME /opt/apache-hive-$HIVE_VERSION-bin
ENV MYSQL_DRIVER_VERSION 5.1.44

# Copy Hadoop config file 
COPY mapred-site.xml $HADOOP_PREFIX/etc/hadoop/

# ADD apache-hive-$HIVE_VERSION-bin.tar.gz /opt/
RUN mkdir -p $HIVE_HOME \
    && curl -SL "http://mirrors.hust.edu.cn/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz" \
    | tar -zxC /opt \
    && rm -f /temp/hive.tar.gz \
    && wget -P $HIVE_HOME/lib/ http://central.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_DRIVER_VERSION/mysql-connector-java-$MYSQL_DRIVER_VERSION.jar 

COPY hive-site.xml $HIVE_HOME/conf/
