# desc : build a Datanode
FROM uhopper/hadoop-datanode:latest

MAINTAINER niushuai(guisu2010@gmail.com)

ENV HADOOP_HOME $HADOOP_PREFIX

# Copy Hadoop config file 
ADD mapred-site.xml $HADOOP_HOME/etc/hadoop/
