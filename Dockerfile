FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

MAINTAINER zopanix <zopanix@gmail.com>


RUN mkdir /opt

WORKDIR /opt

COPY ./smart_launch.sh /opt/
COPY ./factorio.crt /opt/
COPY ./save.zip /opt/factorio/saves

ENV FACTORIO_AUTOSAVE_INTERVAL=2 \
    FACTORIO_AUTOSAVE_SLOTS=3 \
    FACTORIO_DISSALOW_COMMANDS=true \
    FACTORIO_NO_AUTO_PAUSE=false \
    VERSION=0.12.30 \
    FACTORIO_SHA1=9802b22f428eb404369d496f6d40633a64984406

RUN apk --update add bash curl && \
    curl -sSL --cacert /opt/factorio.crt https://www.factorio.com/get-download/$VERSION/headless/linux64 -o /opt/factorio_headless_x64_$VERSION.tar.gz && \
    echo "$FACTORIO_SHA1  /opt/factorio_headless_x64_$VERSION.tar.gz" | sha1sum -c && \
    tar xzf /opt/factorio_headless_x64_$VERSION.tar.gz

EXPOSE 34197/udp

CMD ["./smart_launch.sh"]

