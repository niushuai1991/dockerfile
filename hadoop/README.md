
# 构建一个hadoop集群环境

hadoop分布式模式是真分布式，不是伪分布式。

一、准备工作

1、添加docker的镜像库地址，解决下载速度慢的问题
打开docker设置，【Daemon】-> 【Registry mirrors】,
在里面输入daocloud的镜像地址。需要先到daocloud中注册账号获取地址。

2、在docker里设置共享磁盘，为了方便往 namenode 容器里上传数据，所以把E盘作为了数据卷，需要在docker中设置E盘为共享磁盘。

二、构建映像

构建 namenode 镜像
docker build -t niushuai/namenode hadoop-namenode/
构建 datanode 镜像
docker build -t niushuai/datanode hadoop-datanode/

在 docker 中建立一个网络
docker network create --subnet=172.18.0.0/16 hadoopNet

三、创建实例

创建一个mysql实例，用于存储hive元数据
docker run --name mysql --network-alias=mysql --net hadoopNet --ip 172.18.0.15  -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7

创建hive数据库
docker exec -it mysql mysql -uroot -proot -e 'CREATE SCHEMA `hive` DEFAULT CHARACTER SET utf8'

创建一个namenode容器
docker run -d --name namenode --network-alias=master -h master --net hadoopNet --ip 172.18.0.20 -p 10070:50070 -v //e//hadoop//share://home//share -e "CORE_CONF_fs_defaultFS=hdfs://master:8082" -e "HDFS_CONF_DFS_REPLICATION=2" -e "CLUSTER_NAME=cluster0" niushuai/namenode

创建第一个datanode容器
docker run -d --name datanode1 --network-alias=slave1 -h slave1 --net hadoopNet --ip 172.18.0.21 -e"CORE_CONF_fs_defaultFS=hdfs://master:8082" -e "HDFS_CONF_DFS_REPLICATION=2" -e "CLUSTER_NAME=cluster0" niushuai/datanode:latest

创建第二个datanode容器
docker run -d --name datanode2 --network-alias=slave2 -h slave2 --net hadoopNet --ip 172.18.0.22 -e"CORE_CONF_fs_defaultFS=hdfs://master:8082" -e "HDFS_CONF_DFS_REPLICATION=2" -e "CLUSTER_NAME=cluster0" niushuai/datanode:latest

四、测试

进入namenode容器
docker exec -it namenode /bin/bash

需要在hive bin目录运行以下命令来初始化数据库
cd $HIVE_HOME/bin
./schematool -initSchema -dbType mysql

执行wordcount测试
cd /home/share
把input目录放到HDFS上
hadoop dfs -put ./input /input
执行
hadoop jar hadoop-examples-1.2.1.jar wordcount /input /output

当不需要在容器中使用命令行时可以退出容器
exit



以下是docker相关的命令，当不需要使用上面的实例时使用


关闭容器实例（相当于把容器关机）
docker stop namenode
docker stop datanode1
docker stop datanode2
docker stop mysql

删除容器实例（需要先关闭容器，然后删除）
docker rm namenode
docker rm datanode1
docker rm datanode2
docker rm mysql

删除docker镜像，当不需要再使用以上镜像时，可以用下面的命令删除镜像
docker rm niushuai/hadoop-namenode
docker rm niushuai/hadoop-datanode
