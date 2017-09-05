#!/usr/bin/expect -f
# 设置ssh连接的超时时间
log_file expect.log  
log_user 0
set timeout -1
spawn ssh [lindex $argv 0]@[lindex $argv 1] -p [lindex $argv 2]  "[lindex $argv 3]"
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


