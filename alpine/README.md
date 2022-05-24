# alpine

alpine是比较小的系统基础镜像，镜像大小只有5M多点。

拉取镜像
```shell
docker alpine:3.15
```
用docker images检查镜像，只有5M多
```
REPOSITORY                  TAG                    IMAGE ID       CREATED         SIZE
alpine                      3.15                   c059bfaa849c   4 months ago    5.59MB
```

因为体积太小，镜像中只包含了基本的命令，通过以下命令查看包含的命令
```
docker run --rm alpine:3.15 /bin/ls /bin /usr/bin
```

## 安装curl和telnet命令

指定国内的软件源仓库
```
sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
```

更新apk
```shell
apk update
```
安装curl
```
apk add curl
```

安装telnet
```
apk add busybox-extras
```


