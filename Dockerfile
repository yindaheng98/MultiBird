FROM mattrayner/lamp:latest-1804
MAINTAINER Howard Yin <yindaheng98@163.com>
ENV REFRESHED_AT 2019-07-20

# based on mattrayner/docker-lamp
# MAINTAINER Matthew Rayner <hello@rayner.io>

#配置反向代理
ADD supporting_files/proxy_default /proxy_conf/proxy.conf
RUN a2enmod proxy && \
  a2enmod proxy_http && \
  ln -sf /proxy_conf/proxy.conf /etc/apache2/mods-enabled/proxy.conf

RUN useradd -r jetty && \
    usermod -G staff jetty

#装java
ENV JAVA_URL=https://javadl.oracle.com/webapps/download/AutoDL?BundleId=238719_478a62b7d4e34b78b671c754eaaf38ab

RUN wget ${JAVA_URL} -O jre.tar.gz -q && \
  mkdir /java && \
  tar -zxvf jre.tar.gz -C /java && \
  rm -f jre.tar.gz

ENV JAVA_HOME=/java/jre1.8.0_211
ENV CLASSPATH=.:$JAVA_HOME:$JAVA_HOME/lib
ENV PATH=$JAVA_HOME/bin:$PATH
RUN echo $JAVA_HOME

# 下jetty
ENV JETTY_VERSION=9.4.14.v20181114
RUN wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz -O jetty.tar.gz -q && \
  tar -zxvf jetty.tar.gz && \
  mv jetty-distribution-${JETTY_VERSION} jetty && \
  rm -f jetty.tar.gz

# 装jetty
ENV JETTY_HOME /jetty
ENV PATH $JETTY_HOME/bin:$PATH

# 初始化jettybase
ENV JETTY_BASE /jettybase
RUN mkdir -p "$JETTY_BASE"
WORKDIR $JETTY_BASE
RUN java -jar "$JETTY_HOME/start.jar" --create-startd --add-to-start="server,http,deploy,jsp,jstl,ext,resources,websocket"  && \
	chown -R jetty:jetty "$JETTY_BASE" 

# 初始化jetty缓存
ENV TMPDIR /tmp/jetty
RUN mkdir -p "$TMPDIR" && \
	chown -R jetty:staff "$TMPDIR"

ADD supporting_files/docker-entrypoint.sh /docker-entrypoint.sh
ADD supporting_files/generate-jetty-start.sh /generate-jetty-start.sh
ADD supporting_files/start.sh /start.sh
RUN chmod 755 /*.sh
#ADD supporting_files/supervisord-jetty.conf /etc/supervisor/conf.d/supervisord-jetty.conf
#TODO:java不能用supervisord运行不知道怎么回事，暂时先用/generate-jetty-start.sh搞成后台程序
#求大佬拯救

WORKDIR $JETTY_BASE
EXPOSE 8080 80 3306

# Add volumes for the app
VOLUME  ["/jettybase/webapps", "/etc/mysql", "/var/lib/mysql", "/app", "/proxy_conf"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/start.sh"]
