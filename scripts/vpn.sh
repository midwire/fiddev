echo "Installing VPN..."
apt-get -y install vpnc

echo "IPSec gateway 173.15.1.130" > /etc/vpnc/default.conf
echo "IPSec ID adgroup" >> /etc/vpnc/default.conf
echo "IPSec secret adgroup" >> /etc/vpnc/default.conf
echo "Xauth username cblackburn" >> /etc/vpnc/default.conf
echo "Xauth password F1d3l2013q4" >> /etc/vpnc/default.conf
echo "Domain americadirect.net" >> /etc/vpnc/default.conf

# Login to VPN
vpnc-disconnect
vpnc
