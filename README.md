# shell
一些简单的shell脚本，希望对今后的工作有所帮助（偷偷懒）

## ssh_login
* ssh免登陆修改密码脚本，可批量修改，密码错误登录不了可自动跳过
* 核心是 **expect** 脚本免登陆。登录后做什么操作可以结合 **shell** 脚本完成。

## listen_system_status
* 心跳监听脚本，目前是实现了一个监听tomcat应用并自动重启的的shell
