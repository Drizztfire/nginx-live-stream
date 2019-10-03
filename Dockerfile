FROM alpine

ENV VIDEOJS_VERSION 7.5.5

RUN apk update  \
    && apk add --no-cache openssl ca-certificates wget unzip nginx nginx-mod-rtmp ffmpeg \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /www /var/sock /var/rec \
    && wget -O videojs.zip https://github.com/videojs/video.js/releases/download/v$VIDEOJS_VERSION/video-js-$VIDEOJS_VERSION.zip \
    && unzip -d /www videojs.zip \
    && rm videojs.zip \
    && chown nginx:nginx /www /var/sock /var/rec

ADD nginx.conf /etc/nginx/nginx.conf
ADD stat.xsl /etc/nginx/static/stat.xsl
ADD index.html /www/index.html

VOLUME /var/rec

EXPOSE 80 1935

CMD nginx -g 'daemon off;'
