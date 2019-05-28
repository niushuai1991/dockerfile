FROM uhopper/hadoop-namenode:latest

MAINTAINER niushuai(guisu2010@gmail.com)

ENV HADOOP_HOME $HADOOP_PREFIX
ENV HIVE_VERSION 2.3.4
ENV HIVE_HOME /opt/apache-hive-$HIVE_VERSION-bin
ENV MYSQL_DRIVER_VERSION 5.1.44

# Copy Hadoop config file 
COPY mapred-site.xml $HADOOP_HOME/etc/hadoop/

# Copy Hive
# ADD apache-hive-$HIVE_VERSION-bin.tar.gz /opt/

RUN ls -l /
RUN mkdir -p /opt \
    && curl -SL "http://mirrors.hust.edu.cn/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz" \
    | tar -xJC /opt

# Copy Hive Config file
COPY hive-site.xml $HIVE_HOME/conf/

# Copy MySQL Connector/J Driver to Hive library
COPY http://central.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_DRIVER_VERSION/mysql-connector-java-$MYSQL_DRIVER_VERSION.jar $HIVE_HOME/lib/
