FROM jbonachera/alpine
MAINTAINER Julien BONACHERA <julien@bonachera.fr>

ENV VERSION=0.8.3
RUN apk -U add unzip curl
RUN mkdir /opt
RUN curl -sL https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip -o /opt/consul.zip && \
unzip /opt/consul.zip -d /opt && \
rm /opt/consul.zip && \
cp /opt/consul /usr/local/bin && \
rm -rf /opt/consul
RUN mkdir /etc/consul /var/lib/consul
RUN adduser -S consul
RUN chown consul: /etc/consul /var/lib/consul
RUN chmod +x /usr/local/bin/consul
COPY entrypoint /sbin/entrypoint
USER consul
ENTRYPOINT ["/sbin/entrypoint"]
