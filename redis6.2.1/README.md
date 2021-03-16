# 构建redis



首先拉取官方镜像

```
docker pull redis:6.2.1
```
也可能是
```
docker pull docker.io/redis:6.2.1
```


构建镜像

```
docker build -t djn/redis:6.2.1 .
```



创建容器

```
docker run -d --name redis -p 6379:6379 djn/redis:6.2.1
```



进入容器

```
docker exec -it redis /bin/bash
```

关闭容器
```
docker stop redis
```

启动容器
```
docker start redis
```

删除容器，需要先关闭容器
```
docker rm redis
```

删除镜像，需要先删除容器
```
docker rmi djn/redis:6.2.1
```



使用jedis的连接地址如下：

```
http://default:ibps1234@127.0.0.1:6379/0
```

