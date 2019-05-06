# MultiBird

A Combined Micro Service server based on ubuntu-lamp, with a jetty container.

## 这是什么

这是一个上面装了LAMP+jetty的Ubuntu服务器镜像，并且可以通过自定义proxy.conf实现Apache2反向代理

## 怎么用

这个服务器镜像基于[mattrayner/lamp](https://hub.docker.com/r/mattrayner/lamp)的18.04版本，LAMP的使用方式不变。

把要放进jetty的内容放进一个文件夹里然后用`docker run -v`指令挂载到镜像的`/jettybase/webapps`目录下，并且把8080端口映射到主机上即可。

jetty的输出在`$JETTY_BASE/jetty.log`里

把自定义的`proxy.conf`放在一个文件夹里然后用`docker run -v`指令挂载到镜像的`/proxy_conf`目录下，在启动时的entrypoint脚本里面`/proxy_conf/proxy.conf`会被移动到Apache2的mod配置目录