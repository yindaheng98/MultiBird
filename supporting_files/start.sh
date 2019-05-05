sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
#作者疏忽，有个配置文件没改，导致外网连不上mysql
echo '这也是我的principle'
nohup java -jar $JETTY_HOME/start.jar > /jettybase/webapps/jetty.log  2>&1 &
/run.sh