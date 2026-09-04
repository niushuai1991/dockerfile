FROM docker:cli

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata \
    && ln -sf "$(command -v docker)" /usr/bin/docker

COPY crontab /etc/crontabs/root

CMD ["crond", "-f", "-l", "2"]
