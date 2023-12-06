FROM ubuntu:20.04
ARG RELEASE
ARG LAUNCHPAD_BUILD_ARCH
LABEL org.opencontainers.image.ref.name="ubuntu"
LABEL org.opencontainers.image.version="20.04"
ADD file:4809da414c2d478b4d991cbdaa2df457f2b3d07d0ff6cf673f09a66f90833e81 in / 
CMD ["/bin/bash"]
LABEL maintainer="ownCloud GmbH <devops@owncloud.com>" \
      org.opencontainers.image.authors="ownCloud DevOps <devops@owncloud.com>" \
      org.opencontainers.image.title="ownCloud Ubuntu" \
      org.opencontainers.image.url="https://hub.docker.com/r/owncloud/ubuntu" \
      org.opencontainers.image.source="https://github.com/owncloud-docker/ubuntu" \
      org.opencontainers.image.documentation="https://github.com/owncloud-docker/ubuntu"
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm
ENV GOMPLATE_VERSION=v3.11.6
ENV WAIT_FOR_VERSION=v2.0.1
ENV RETRY_VERSION=v2.0.0
RUN |3 TARGETOS=linux TARGETARCH=amd64 TARGETVARIANT= /bin/sh -c apt-get update -y &&   apt-get install --no-install-recommends -y     ca-certificates     bash     curl     wget     procps     apt-utils     apt-transport-https     bzip2     cron     jq     gnupg     libnss-wrapper &&   apt-get clean &&   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* # buildkit
RUN |3 TARGETOS=linux TARGETARCH=amd64 TARGETVARIANT= /bin/sh -c curl -SsfL -o /usr/bin/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_${TARGETOS}-${TARGETARCH}${TARGETVARIANT}" &&     curl -SsfL -o /usr/bin/wait-for "https://github.com/owncloud-ci/wait-for/releases/download/${WAIT_FOR_VERSION}/wait-for-${TARGETOS}-${TARGETARCH}${TARGETVARIANT}" &&     curl -SsfL -o /usr/bin/retry "https://github.com/owncloud-ci/retry/releases/download/${RETRY_VERSION}/retry" &&     chmod 755 /usr/bin/gomplate &&     chmod 755 /usr/bin/wait-for &&     chmod 755 /usr/bin/retry # buildkit
ADD overlay / # buildkit
CMD ["bash"]
LABEL maintainer="ownCloud GmbH <devops@owncloud.com>" \
      org.opencontainers.image.authors="ownCloud DevOps <devops@owncloud.com>" \
      org.opencontainers.image.title="ownCloud PHP" \
      org.opencontainers.image.url="https://hub.docker.com/r/owncloud/php" \
      org.opencontainers.image.source="https://github.com/owncloud-docker/php" \
      org.opencontainers.image.documentation="https://github.com/owncloud-docker/php"
EXPOSE 8080/tcp
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/server"]
RUN /bin/sh -c apt-get update
ADD overlay / # buildkit
WORKDIR /var/www/html
LABEL maintainer="ownCloud GmbH <devops@owncloud.com>" \
      org.opencontainers.image.authors="ownCloud DevOps <devops@owncloud.com>" \
      org.opencontainers.image.title="ownCloud Base" \
      org.opencontainers.image.url="https://hub.docker.com/r/owncloud/base" \
      org.opencontainers.image.source="https://github.com/owncloud-docker/base" \
      org.opencontainers.image.documentation="https://github.com/owncloud-docker/base"
RUN /bin/sh -c mkdir -p
ADD overlay / # buildkit
WORKDIR /var/www/owncloud
RUN /bin/sh -c chgrp root
VOLUME [/mnt/data]
EXPOSE 8080/tcp
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/owncloud" "server"]
LABEL maintainer="ownCloud GmbH <devops@owncloud.com>" \
      org.opencontainers.image.authors="ownCloud DevOps <devops@owncloud.com>" \
      org.opencontainers.image.vendor="ownCloud GmbH" \
      org.opencontainers.image.title="ownCloud Server" \
      org.opencontainers.image.description="ownCloud - Secure Collaboration Platform" \
      org.opencontainers.image.url="https://hub.docker.com/r/owncloud/server" \
      org.opencontainers.image.source="https://github.com/owncloud-docker/server" \
      org.opencontainers.image.documentation="https://github.com/owncloud-docker/server"
ADD owncloud.tar.bz2 /var/www/ # buildkit
ADD overlay / # buildkit
WORKDIR /var/www/owncloud
RUN /bin/sh -c find /var/www/owncloud
VOLUME [/mnt/data]
EXPOSE 8080/tcp
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/owncloud" "server"]