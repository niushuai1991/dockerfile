# docker-prune

每天北京时间 03:00 执行 `/usr/bin/docker image prune -f`，清理宿主机悬空镜像。

```bash
docker compose up -d --build
docker compose logs -f
```
