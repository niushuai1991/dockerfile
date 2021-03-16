# MongoDB



```
docker pull mongo:3.4
```





```
docker run -itd --name mongo -p 28028:27017 mongo
```

创建容器，需要认证才能访问容器服务

```
docker run -itd --name mongo -p 28018:27017 mongo --auth
```

