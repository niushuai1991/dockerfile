FROM uhopper/hadoop-namenode:latest

MAINTAINER niushuai "https://github.com/niushuai1991"

ENV HIVE_VERSION 2.3.4
ENV HIVE_HOME /opt/apache-hive-$HIVE_VERSION-bin
ENV MYSQL_DRIVER_VERSION 5.1.44

# Copy Hadoop config file 
COPY mapred-site.xml $HADOOP_PREFIX/etc/hadoop/

# ADD apache-hive-$HIVE_VERSION-bin.tar.gz /opt/
RUN mkdir -p $HIVE_HOME \
    && curl -SL "http://mirrors.hust.edu.cn/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz" \
    | tar -zxC /opt \
    && cd $HIVE_HOME/lib/ \
    && { curl -O http://central.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_DRIVER_VERSION/mysql-connector-java-$MYSQL_DRIVER_VERSION.jar ; cd -; }

COPY hive-site.xml $HIVE_HOME/conf/
