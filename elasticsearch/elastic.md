# 



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



