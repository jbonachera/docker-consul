FROM fedora:23
MAINTAINER Julien BONACHERA <julien@bonachera.fr>

ENV VERSION=0.5.2
RUN curl -sL https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip -o /opt/consul.zip && python3 -m zipfile -e /opt/consul.zip /opt && rm /opt/consul.zip && cp /opt/consul /usr/local/bin && rm -rf /opt/consul
RUN curl -sL https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_web_ui.zip -o /opt/consul-ui.zip && python3 -m zipfile -e /opt/consul-ui.zip  /opt && rm /opt/consul-ui.zip && mv /opt/dist /opt/consul-ui/
RUN mkdir /etc/consul
RUN useradd -r consul
RUN chown consul: /etc/consul
RUN chmod +x /usr/local/bin/consul
CMD ["/usr/local/bin/consul", "agent", "-server", "-bootstrap", "-data-dir", "/srv/consul", "-ui-dir", "/opt/consul-ui/", "-config-dir", "/etc/consul", "-client", "172.17.42.1"]
