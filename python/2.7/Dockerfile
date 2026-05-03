FROM        debian:bookworm-slim

LABEL       author="apuru katze" maintainer="admin@apuru-katze"
LABEL       org.opencontainers.image.source="https://github.com/apuru-katze/pterodactyl-images"
LABEL       org.opencontainers.image.licenses="MIT"

RUN         apt-get update \
            && apt-get -y install --no-install-recommends \
               git gcc g++ ca-certificates dnsutils curl iproute2 ffmpeg procps locales \
               make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
               libsqlite3-dev wget libncurses5-dev libncursesw5-dev xz-utils \
               tk-dev libffi-dev liblzma-dev \
            && cd /tmp \
            && wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz \
            && tar xzf Python-2.7.18.tgz \
            && cd Python-2.7.18 \
            && ./configure --enable-optimizations --prefix=/usr/local \
            && make -j$(nproc) \
            && make install \
            && cd / && rm -rf /tmp/Python-2.7.18* \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -m -d /home/container container \
            && locale-gen en_US.UTF-8

ENV         LC_ALL=en_US.UTF-8
ENV         LANG=en_US.UTF-8
ENV         LANGUAGE=en_US.UTF-8

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
