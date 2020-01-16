# NextCloud安装


使用Docker安装

```
docker pull nextcloud
docker pull mysql:8
```

创建一个网络
docker network create --subnet=172.18.0.0/16 dockernet

创建mysql容器，别名mysql1
```
docker run -p 3306:3306 --restart always --name mysql1 --network-alias=mysql1 --net dockernet --ip 172.18.0.15 -v /etc/localtime:/etc/timezone:rw -v /etc/localtime:/etc/localtime:rw -e MYSQL_ROOT_PASSWORD=Qwe@123456 -d  mysql:8 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```

在MySQL创建一个数据库
```mysql
create database nextcloud default character set utf8mb4 collate utf8mb4_unicode_ci;
```

创建nextcloud容器，映射到本地80端口
```
docker run -d -p 8080:80 --restart always --name nextcloud --network-alias=nextcloud --net dockernet nextcloud
```



docker run -p 3306:3306 --restart always --name mysql1 --network-alias=mysql1 --net dockernet --ip 172.18.0.15 -v /etc/localtime:/etc/timezone:rw -v /etc/localtime:/etc/localtime:rw -e MYSQL_ROOT_PASSWORD=Qwe@123456 -d  mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

docker run -d -p 8080:80 nextcloud



## Redis caching

```
docker pull redis:5.0
docker run --name redis --restart always --net=dockernet -p 6379:6379 -d redis:5.0
```

通过redis-cli进行连接
```
docker run -it --network dockernet --rm redis:5.0 redis-cli -h redis
```

在config.php中 **'memcache.local' => '\OC\Memcache\APCu',** 后面添加以下内容

```
'memcache.locking' => '\OC\Memcache\Redis',
'memcache.distributed' => '\OC\Memcache\Redis',
'redis' => [
     'host' => 'redis',
     'port' => 6379,
],
```

先进容器看一下config.php的权限

```
# ls -l /var/www/html/config/config.php
-rw-r----- 1 www-data www-data 988 Oct 10 20:01 /var/www/html/config/config.php
```

把配置文件放到容器中
```
docker cp config.php nextcloud:/var/www/html/config/
```
对比之后发现是所属用户和组错了，使用chown进行修改。

```
chown www-data:www-data /var/www/html/config/config.php
```

然后重启nextcloud容器，就完成了缓存的配置。


参考资料
https://www.knthost.com/nextcloud/setup-nextcloud-memory-caching-apcu-and-redis
Memory caching -- Nextcloud
https://docs.nextcloud.com/server/17/admin_manual/configuration_server/caching_configuration.html
https://sleele.com/2019/04/19/docker-nextcloud-redis%e7%bc%93%e5%ad%98%e9%85%8d%e7%bd%ae/
