## 说明
这个环境使用的映像都是官方映像，所以只有构建过程。


## 操作

### 1.创建一个网络

docker network create --subnet=172.18.0.0/16 hadoopNet

### 创建一个mysql容器

```
docker run --name mysql --net hadoopNet --ip 172.18.0.15  -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql --max_allowed_packet=20971520
```

需要注意的是，命令里包含一个参数***--max_allowed_packet=20971520***，这个参数是设置每次最大提交多大的数据量，如果该太小的话，当sonarqube上传的扫描结果过大时会上传失败。

在mysql中创建数据库：

```
CREATE SCHEMA `sonar` DEFAULT CHARACTER SET utf8 ;
```

### 创建一个sonar容器

需要注意的是，在jdbc url里不能使用&，不然会被当作shell的&符，命令会解析错误导致不能正常创建容器，所以使用单引号把url引起来

```
docker run -d --name sonarqube --net hadoopNet --ip 172.18.0.16 -p 9000:9000 -p 9092:9092 -e SONARQUBE_JDBC_USERNAME=root -e SONARQUBE_JDBC_PASSWORD=root -e SONARQUBE_JDBC_URL='jdbc:mysql://mysql:3306/sonar?characterEncoding=utf8&useUnicode=true' sonarqube
```
