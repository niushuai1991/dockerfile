FROM python:3.10-slim

SHELL [ "/bin/bash", "-c" ]

ENV SHELL=/bin/bash
ENV MARKER_HOME=/opt/marker
ENV MARKER_VERSION=1.5.3
ENV PATH="$MARKER_HOME:/root/.local/bin:${PATH}"

COPY sample.pdf docker-entrypoint.sh monitor_marker.sh /opt

WORKDIR /opt

RUN apt update && \
    apt upgrade -y && \
    apt install curl libgl1 libglib2.0-0 gpg wget -y && \
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && \
    apt-get update && \
    apt-get install -y nvidia-container-toolkit && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    /root/.local/bin/poetry config virtualenvs.create false && \
    wget https://github.com/VikParuchuri/marker/archive/refs/tags/v$MARKER_VERSION.tar.gz -O marker.tar.gz && \
    tar -zxf marker.tar.gz && \
    mv marker-$MARKER_VERSION marker && \
    rm -f marker.tar.gz && \
    chmod +x /opt/marker/*.py && \
    chmod +x /opt/*.sh && \
    apt remove wget -y && \
    apt autoclean -y && \
    apt autoremove -y

EXPOSE 80
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
