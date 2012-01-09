#!/bin/sh
/bin/cat <<EOF > /etc/rc.local
apt-get update
apt-get -y upgrade
apt-get install -y curl
curl https://raw.github.com/gist/1176137/cdcd77e1ede950de1d598b701ecd92fa8de18425/setup_in_startup_script.sh | sh | tee /root/_setup.log
/bin/sed -i.orig -e "s/apt/#apt/g" /etc/rc.local
/bin/sed -i.orig -e "s/curl/#curl/g" /etc/rc.local
/bin/sed -i.orig -e "s/\/bin\/sed/#\/bin\/sed/g" /etc/rc.local
exit 0
EOF