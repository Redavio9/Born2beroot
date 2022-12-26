#!/bin/bash

Architecture=$(uname -a)
CPU_physical=$(cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l)
vCPU=$(cat /proc/cpuinfo | grep "processor" | wc -l)
Memory_t=$(free -m | grep "Mem" | awk '{print $2}')
Memory_u=$(free -m | grep "Mem" | awk '{print $3}')
Memory_f=$(free -m | grep "Mem" | awk '{printf "(%.2f%%)", $3/$2*100}')
Disk_T=$(df -m --total | grep "total" | awk '{printf "%d/%dGb (%d%%)", $3,($4/1024),$5}')
Cpu_L=$(top -bn1 | grep "%Cpu" | awk -F ',' '{print $4}' | awk '{printf "%.1f%%", 100 - $1}')
Last_b=$(who -b | awk '{print $3" "$4}')
Lvm=$(if [ $(lsblk | grep "lvm" | wc -l) > 0 ]; then echo yes; else echo no; fi)
cTCP=$(ss -ta |grep ESTAB |wc -l)
Userlog=$(who | awk '{print $1}'| sort -u | wc -l)
ADDIP=$(hostname -I)
ADDMAC=$(ip link | grep "link/ether" | awk '{print $2}')
sudo=$(ls /var/log/sudo/00/00 | wc -w)




wall "
#Architecture: $Architecture
#CPU physical: $CPU_physical
#vCPU: $vCPU
#Memory Usage: $Memory_u/${Memory_t}MB $Memory_f
#Disk Usage: $Disk_T
#CPU load: $Cpu_L
#Last boot: $Last_b
#LVM use: $Lvm
#Connections TCP: $cTCP ESTABLISHED
#User log: $Userlog
#Network : IP $ADDIP($ADDMAC)
#Sudo : $sudo cmd
     "
