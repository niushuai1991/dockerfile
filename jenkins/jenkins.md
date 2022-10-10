# 在docker中使用jenkins

测试环境是在 WSL2 Ubuntu
使用jenkins版本 2.60.3




```
docker pull jenkins/jenkins:lts-jdk11
```


先给本地目录设置权限，用来给容器当卷使用。
```
sudo chown ns:ns jenkins_home
```
创建容器

```
docker run -d -p 8000:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home  --name jenkins jenkins/jenkins:lts-jdk11
```


