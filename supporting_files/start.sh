echo '我加的'
su - jetty -c nohup java -jar $JETTY_HOME/start.jar > log.file  2>&1 &
/run.sh