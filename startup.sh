#!/bin/sh
/bin/cat <<EOF > /etc/rc.local
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y curl
curl https://raw.github.com/yuyalush/startup_for_ror/master/setup_in_statup_script.sh | sh | tee /root/_setup.log
/bin/sed -i.orig -e "s/apt/#apt/g" /etc/rc.local
/bin/sed -i.orig -e "s/curl/#curl/g" /etc/rc.local
/bin/sed -i.orig -e "s/\/bin\/sed/#\/bin\/sed/g" /etc/rc.local
exit 0
EOF
