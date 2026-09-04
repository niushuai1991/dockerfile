# docker-prune

每天 **北京时间 03:00** 执行 `/usr/bin/docker image prune -f`，清理宿主机悬空镜像。

## 部署

```bash
docker compose up -d --build
docker compose logs -f          # 跟随日志；Ctrl+C 只退出查看
```

手动试跑：

```bash
docker compose exec docker-prune /usr/bin/docker image prune -f
```

容器常驻即可，不必每天重建；改 `Dockerfile` / `crontab` 后再 `--build`。

## 方案对比（对话里讨论过的）

目标相同：定时在「能操作宿主机 Docker」的环境里跑 `image prune -f`。

| 方案 | 做法概要 | 结论 |
|------|----------|------|
| **A. `docker:cli` + 容器内 `crond`（当前）** | 官方客户端镜像 + 挂 `docker.sock` + 容器内 crontab | **采用**：客户端与依赖自带，最稳 |
| **B. 挂载宿主机 `/usr/bin/docker`** | 小镜像里挂 `/usr/bin/docker` + `docker.sock` | **不推荐**：见下方坑 |
| **C. `mcuadros/ofelia`** | 用 Ofelia 调度，再间接执行 prune | **本任务不值**：见下方坑 |
| **D. `supercronic`** | 在 `docker:cli` 里换用 supercronic 做定时 | **曾考虑后放弃**：见下方坑 |

### 为什么用 A，不用你提的 B / C

**B — 挂载 `/usr/bin/docker:/usr/bin/docker`**

- 看起来更「轻」、不用带一整份 `docker:cli`。
- **坑**：宿主机 `docker` 多为 **glibc 动态链接**；若容器是 Alpine（**musl**），挂进去经常直接无法执行。
- **坑**：只挂二进制不够时还要处理动态库；仍必须挂 `docker.sock`。
- 能做成，但不稳、易踩坑，不如 A。

**C — 换成 `mcuadros/ofelia`**

- Ofelia 本身很轻（约几十 MB），适合给**很多容器**挂很多定时任务。
- **坑**：Ofelia 一般**不带** Docker CLI；要跑 `docker image prune`，还得再 `job-run` 起 `docker:cli`，或另备带客户端的容器。
- 对「就这一条每日 prune」来说更绕，体积优势也有限（执行时仍依赖 `docker:cli`）。

**D — `supercronic`（对比补充）**

- 比 busybox `crond` 更「容器友好」，日志更好。
- **坑**：构建要从 GitHub 拉二进制，网络不稳时构建容易卡住；单任务过重。

### A 里各部分在干什么

- `docker:cli`：官方 **Docker 客户端**（有 `docker` 命令，没有 dockerd）。
- 挂载 `/var/run/docker.sock`：客户端操作的是**宿主机** Docker。
- 容器内 `crond`（不是宿主机 crontab）+ `TZ=Asia/Shanghai`：每天 03:00 触发。

## 行为说明

`docker image prune -f` 只删悬空镜像，不动正在使用的镜像。更激进的 `system prune` 等需自行改命令并评估风险。
