FROM alpine:3.15

LABEL maintainer="Cesar Gaspar <rasec.rapsag@gmail.com>"
LABEL description="Run the truecrypt tool inside a docker container."

ARG WX_VERSION=2.8.12

RUN apk --no-cache --update  add libuuid git alpine-sdk nasm fuse-dev device-mapper python3 && \
    cd /tmp && git clone https://github.com/RasecRapsag/TCryptSource.git && \
    wget -O /tmp/wx.tar.gz "https://github.com/wxWidgets/wxWidgets/archive/v${WX_VERSION}.tar.gz" && \
    cd /tmp && tar -xzvf wx.tar.gz && rm wx.tar.gz && \
    cd /tmp/TCryptSource && make NOGUI=1 WX_ROOT=/tmp/wxWidgets-${WX_VERSION} wxbuild && \
    mv /tmp/wxWidgets-${WX_VERSION}/include/wx /usr/include/wx && \
    cp /tmp/TCryptSource/wxrelease/lib/wx/include/base-unicode-release-static-${WX_VERSION:0:3}/wx/setup.h /usr/include/wx/setup.h && \
    sed -i '1 i\#pragma GCC diagnostic ignored "-Wnarrowing"' /tmp/TCryptSource/Main/Resources.cpp && \
    ln -s /tmp/TCryptSource/wxrelease/wx-config /usr/bin/wx-config && \
    make NOGUI=1 WXSTATIC=1 && \
    cp /tmp/TCryptSource/Main/truecrypt /usr/local/bin/truecrypt && \
    rm -f /usr/bin/wx-config && \
    cd /tmp && rm -rf TCryptSource wxWidgets-${WX_VERSION} && \
    apk del --no-cache libuuid git alpine-sdk nasm

WORKDIR /crypt

VOLUME [ "/crypt" ]

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
