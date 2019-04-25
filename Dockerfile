FROM mattrayner/lamp:latest-1804
MAINTAINER Howard Yin <yindaheng98@163.com>
ENV REFRESHED_AT 2019-04-17

# based on mattrayner/docker-lamp
# MAINTAINER Matthew Rayner <hello@rayner.io>

# Tweaks to give Apache/PHP write permissions to the app
RUN groupadd -r jetty && useradd -r -g jetty jetty

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt install -y software-properties-common dirmngr && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install oracle-java8-installer && \
  apt-get install nodejs && \
  apt-get install npm && \
  apt-get -y autoremove

# install jetty
ENV JETTY_VERSION=9.4.14.v20181114
RUN wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz -O jetty.tar.gz && \
  tar -zxvf jetty.tar.gz && \
  mv jetty-distribution-${JETTY_VERSION} jetty

ENV JETTY_BASE /var/lib/jetty
RUN mkdir -p "$JETTY_BASE"
WORKDIR $JETTY_BASE
RUN java -jar "$JETTY_HOME/start.jar" --create-startd --add-to-start="server,http,deploy,jsp,jstl,ext,resources,websocket"  && \
	chown -R jetty:jetty "$JETTY_BASE" 

ENV TMPDIR /tmp/jetty
RUN mkdir -p "$TMPDIR" && \
	chown -R jetty:jetty "$TMPDIR"

COPY docker-entrypoint.sh generate-jetty-start.sh /

USER jetty
EXPOSE 8080

# Add volumes for the app
VOLUME  ["/var/lib/jetty/webapps"]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]

