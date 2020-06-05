# jenkins


#!/usr/bin/env bash
#https://techstat.net/automatic-whitelist-cloudflare-ips-firewalld-bash-script-via-cron-job/

SERVER_IP=xxx.xxx.xxx.xxx

for i in $(curl "https://www.cloudflare.com/ips-v4"); do sudo firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address="'$i'" port port=80 protocol=tcp accept'; done
for i in $(curl "https://www.cloudflare.com/ips-v4"); do sudo firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address="'$i'" port port=443 protocol=tcp accept'; done

for i in $(curl "https://www.cloudflare.com/ips-v6"); do sudo firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv6" source address="'$i'" port port=80 protocol=tcp accept'; done
for i in $(curl "https://www.cloudflare.com/ips-v6"); do sudo firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv6" source address="'$i'" port port=443 protocol=tcp accept'; done

firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address="'${SERVER_IP}'" port port=22 protocol=tcp accept'
firewall-cmd --permanent --change-zone=eth0 --zone=public
sudo firewall-cmd --reload

firewall-cmd --list-all



List sources for your zone:

firewall-cmd --permanent --zone=public --list-sources
If there are none, you can start to add them, this is your "whitelist"

firewall-cmd --permanent --zone=public --add-source=192.168.100.0/24
firewall-cmd --permanent --zone=public --add-source=192.168.222.123/32
(That adds a whole /24 and a single IP)

Set the range of ports you'd like open:

firewall-cmd --permanent --zone=public --add-port=1-22/tcp
firewall-cmd --permanent --zone=public --add-port=1-22/udp
This just does ports 1 through 22. You can widen this, if you'd like.

Reload:

firewall-cmd --reload
Check:

firewall-cmd --zone=public --list-all
