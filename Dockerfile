FROM alpine:3.7

RUN apk -U add ansible bash tini

COPY root/. /
ENTRYPOINT [ "tini", "bash", "/entrypoint.sh" ]
CMD [ "create" ]
