# Marker-PDF in Docker



## Run

```
services:
  marker:
    container_name: marker
    image: marker:1.5.3
    restart: unless-stopped
    ports:
      - 80:80
    volumes:
      - /etc/localtime:/etc/localtime:ro
    environment:
      - POETRY_PYPI_URL=https://pypi.tuna.tsinghua.edu.cn/simple
    deploy:
      resources:
        limits:
          cpus: '0.50'
          memory: '4G'
        reservations:
          devices:
            - driver: "nvidia"
              count: "all"
              capabilities: ["gpu"]
```


## build
```
docker buildx create --name marker_builder --driver-opt env.http_proxy=http://172.19.144.1:7890 --driver-opt env.https_proxy=http://172.19.144.1:7890
docker buildx build --builder marker_builder --build-arg MARKER_VERSION=1.5.3 -t marker:1.5.3 --load .
docker buildx rm marker_builder
```
