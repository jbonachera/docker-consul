FROM jbonachera/alpine
MAINTAINER Julien BONACHERA <julien@bonachera.fr>

ENTRYPOINT ["/sbin/entrypoint"]
ENV VERSION=0.8.4
RUN apk -U add unzip curl bind-tools
RUN mkdir /opt
RUN adduser -S consul
RUN curl -sL https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip -o /opt/consul.zip && \
    unzip /opt/consul.zip -d /opt && \
    rm /opt/consul.zip && \
    cp /opt/consul /usr/local/bin && \
    rm -rf /opt/consul && \
    chmod +x /usr/local/bin/consul && \
    mkdir /etc/consul /var/lib/consul /etc/templates && \
    chown consul: /etc/consul /var/lib/consul
VOLUME ["/var/lib/consul"]
COPY entrypoint /sbin/entrypoint
