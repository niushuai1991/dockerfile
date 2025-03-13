# webdav


对webdav进行测试


连接
```
curl -u ns:Qi3!@i4fs342 http://localhost:6065
```


创建目录
```
curl -X MKCOL -u ns:Qi3!@i4fs342 http://localhost:6065/test
```

上传文件
```
curl -u ns:Qi3!@i4fs342 -T test.txt http://localhost:6065/test/test.txt
```

在使用内网穿透后，通过服务器进行测试
```
curl -u ns:Qi3!@i4fs342 http://60.205.247.227:6065
```
