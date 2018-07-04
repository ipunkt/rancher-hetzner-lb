FROM alpine:3.7

RUN apk --update add py-pip bash tini ca-certificates curl jq py-requests openssh-keygen openssh-client \
	&& apk add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base \
	&& pip install ansible \
	&& apk del build-dependencies \
	&& rm -rf /var/cache/apk/*

COPY root/. /
WORKDIR /opt/playbook
ENTRYPOINT [ "tini", "bash", "/entrypoint.sh" ]
CMD [ "create" ]
