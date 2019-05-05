echo '这也是我的principle'
nohup java -jar $JETTY_HOME/start.jar > /jettybase/webapps/jetty.log  2>&1 &
/run.sh