# 在docker中启动elasticsearch



# ElasticSearch6配置



创建一个网络



```
docker network create --subnet=172.18.0.0/16 testnet
```



创建ES容器

```
docker run -d --name elasticsearch --network-alias=elasticsearch --net testnet -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:6.8.17
```



创建kibana容器

```
docker run -d --name kibana --net testnet -p 5601:5601 kibana:6.8.17
```





## ElasticSearch 7配置

```
docker run -d --name=es7 --restart=always --network-alias=es7 --net=payplatform -p 9201:9200 -p 9301:9300 -e "discovery.type=single-node" elasticsearch:7.14.1
```



kibana

```
docker run -d --name=kibana7 --restart=always --network-alias=kibana7 --net=payplatform -p 5602:5601 -e="ELASTICSEARCH_HOSTS=http://es7:9200" kibana:7.14.1
```

