FROM        amazoncorretto:25-jdk

LABEL       author="apuru katze" maintainer="admin@apuru-katze"
LABEL       org.opencontainers.image.source="https://github.com/apuru-katze/pterodactyl-images"
LABEL       org.opencontainers.image.licenses="MIT"

RUN         dnf upgrade -y \
            && dnf install -y curl ca-certificates openssl git tar sqlite fontconfig freetype libstdc++ freetype-devel lsof tzdata iproute \
            gcc gcc-c++ automake make libtool \
            && dnf clean all \
            && rm -rf /var/cache/dnf \
            && useradd -m -d /home/container container

ENV         LC_ALL=en_US.UTF-8
ENV         LANG=en_US.UTF-8
ENV         LANGUAGE=en_US.UTF-8

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
