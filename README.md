# MultiBird

A Combined Micro Service server based on nodejs and ubuntu-lamp, with a jetty container.

## 这是什么

这是一个上面装了LAMP+jetty+nodejs的Ubuntu服务器镜像

这个镜像里面包含一个nodejs转发程序，当配置好文件之后，所有的数据流都会通过nodejs转发到PHP或者jetty中

是“混合微服务”(CMS)的简单实现

## 怎么用

这个服务器镜像基于[mattrayner/lamp](https://hub.docker.com/r/mattrayner/lamp)的18.04版本，LAMP的使用方式不变。

把要放进jetty的内容放进一个文件夹里然后用`docker run -v`指令挂载到镜像的`/jettybase/webapps`目录下，并且把8080端口映射到主机上即可。

jetty的输出在`$JETTY_BASE/jetty.log`里面