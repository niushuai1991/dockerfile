# MySQL

使用下面的命令将mysql的编码配置为utf8mb4，并设置root密码
docker run -p 3306:3306 --restart always --name mymysql -v /etc/localtime:/etc/timezone:rw -v /etc/localtime:/etc/localtime:rw -e MYSQL_ROOT_PASSWORD=My_PASSWORD -d  mysql:8 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci



TODO 暂停，因为可能需要考虑/var/lib/mysql 目录映射后的权限问题

如果需要将MySQL的数据目录保存到实体机，可以映射到本机

先检查数据是保存在哪个目录
show variables like "%datadir%";

另外 binlog也是很重要的数据
```
show variables like "%log_bin%";
```
数据是保存在/var/lib/mysql/ 目录中


运行后在客户端中检查编码
```
show variables like "%char%";
```
