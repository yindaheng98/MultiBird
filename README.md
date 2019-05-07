# MultiBird

A Combined Micro Service server based on ubuntu-lamp, with a jetty container.

## What's this 这是什么

这是一个上面装了LAMP+jetty的Ubuntu服务器镜像，并且可以通过自定义proxy.conf实现Apache2反向代理从而构建CMS。

This is a Combined Micro Service server based on [mattrayner/lamp:1804](https://hub.docker.com/r/mattrayner/lamp), with a [jetty](http://www.eclipse.org/jetty/) in it.

And you can enable Apache2's reverse proxy to make a Combined Micro Service system.

## How to use it 怎么用

这个服务器镜像基于[mattrayner/lamp](https://hub.docker.com/r/mattrayner/lamp)的18.04版本，LAMP的使用方式不变。

Use the lamp just like [mattrayner/lamp](https://hub.docker.com/r/mattrayner/lamp).

把要放进jetty的内容放进一个文件夹里然后用`docker run -v`指令挂载到镜像的`/jettybase/webapps`目录下，并且把8080端口映射到主机上即可。

Use the jetty like this👇

    docker run -v "/your/path/to/webapps:/jettybase/webapps" -p "8080:8080" yindaheng98/multibird-cms

jetty的输出在`/jettybase/webapps/jetty.log`里

jetty will output the log to `/jettybase/webapps/jetty.log`

把自定义的`proxy.conf`放在一个文件夹里然后用`docker run -v`指令挂载到镜像的`/proxy_conf`目录下，mod配置目录有一个指向`/proxy_conf/proxy.conf`的链接

Use Apache2's reverse proxy👉Write a `proxy.conf` and put it into `/your/path/to/proxy_conf` and👇

    docker run -v "/your/path/to/proxy_conf:/proxy_conf" yindaheng98/multibird-cms

What? Don't know how to write configuration file `proxy.conf`? Here👉[Reverse Proxy Guide](http://httpd.apache.org/docs/2.4/howto/reverse_proxy.html).