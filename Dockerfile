FROM lscr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

ARG ACBR_VERSION=3.25.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip ca-certificates \
      libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 \
      libuuid1 libsecret-1-0 libgbm1 libasound2t64 && \
    curl -fsSL -o /tmp/acbr.zip \
      "https://github.com/binarynonsense/comic-book-reader/releases/download/v${ACBR_VERSION}/ACBR_Linux_deb.zip" && \
    unzip -q /tmp/acbr.zip -d /tmp && \
    apt-get install -y /tmp/ACBR_Linux_deb/*.deb && \
    apt-get purge -y unzip && apt-get autoremove -y && \
    rm -rf /tmp/* /var/lib/apt/lists/*

RUN printf '%s\n' '#!/bin/bash' \
      'exec "/opt/ACBR Comic Book Reader/acbr-comic-book-reader" --no-sandbox --disable-gpu' \
      > /defaults/autostart && \
    chmod +x /defaults/autostart

EXPOSE 3000 3001
VOLUME /config
