# vsftpd





```
docker run -d -p 21:21 -v /my/data/directory:/home/vsftpd --name vsftpd fauria/vsftpd
```





```
docker run -d -p 21:21 -v D:\ftp\user1:/home/vsftpd -e FTP_USER=user1 -e FTP_PASS=user1 --name vsftpd fauria/vsftpd
```

在wsl2里失败了

