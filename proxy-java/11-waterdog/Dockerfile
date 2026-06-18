FROM        eclipse-temurin:11-focal

LABEL       author="Kucing" maintainer="kucing@zelpstore.com"
LABEL       org.opencontainers.image.source="https://github.com/apuru-katze/pterodactyl-images"
LABEL       org.opencontainers.image.licenses="MIT"

RUN         microdnf update \
            && microdnf install -y jq curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute gcc gcc-c++ freetype libstdc++ lsof glibc-locale-source glibc-langpack-en \
            && microdnf clean all \
            && adduser --home-dir /home/container container

ENV         LC_ALL=en_US.UTF-8
ENV         LANG=en_US.UTF-8
ENV         LANGUAGE=en_US.UTF-8

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
