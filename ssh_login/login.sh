#!/usr/bin/expect -f
# 设置日志文件位置
log_file expect.log  
# 是否将命令回显显示在屏幕或日志中，默认1是。
log_user 0
# 设置ssh连接的超时时间 -1为永不超时
set timeout 20
spawn ssh [lindex $argv 0]@[lindex $argv 1] -p [lindex $argv 2]  "[lindex $argv 3]"
expect "*(yes/no)" {
# 确认链接
send "yes\r"
}
expect "*password:" {
# 提交密码
send "[lindex $argv 4]\r"
}
expect "*Permission denied" {
# 退出输入
send "\03\r"
send_user "The password of host [lindex $argv 1] is not right, connect fail"
}

# 控制权移交
interact


