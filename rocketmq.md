# rocketmq

参考https://www.cnblogs.com/kiwifly/p/11546008.html





拉取镜像

```
docker pull rocketmqinc/rocketmq:4.4.0
```



**启动namesrv服务**



```
docker run -d -p 9876:9876 -v /opt/rocketmq/namesrv/logs:/root/logs -v /opt/rocketmq/namesrv/store:/root/store --name rmqnamesrv -e "MAX_POSSIBLE_HEAP=100000000" rocketmqinc/rocketmq:4.3.2 sh mqnamesrv
```

**启动broker服务**

```
docker run -d -p 10911:10911 -p 10909:10909 -v /opt/rocketmq/broker/logs:/root/logs -v /opt/rocketmq/broker/store:/root/store --name rmqbroker --link rmqnamesrv:namesrv -e "NAMESRV_ADDR=namesrv:9876" -e "MAX_POSSIBLE_HEAP=200000000" rocketmqinc/rocketmq:4.3.2 sh mqbroker
```











