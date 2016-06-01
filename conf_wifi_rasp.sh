sudo apt-get -y install hostapd udhcpd isc-dhcp-server

/etc/dhcp/dhcpd.conf:
#option domain-name "example.org";
#option domain-name-servers ns1.example.org, ns2.example.org;
authoritative;
subnet 10.0.2.0 netmask 255.255.255.0 {
range 10.0.2.1 10.0.2.254;
option broadcast-address 10.0.2.255;
option routers 10.0.2.1;
default-lease-time 600;
max-lease-time 7200;
option domain-name "local";
option domain-name-servers 8.8.8.8, 8.8.4.4;
}

/etc/default/isc-dhcp-server:
INTERFACES="wlan0"

/etc/default/hostapd:
DAEMON_CONF="/etc/hostapd/hostapd.conf"

sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

/etc/sysctl.conf:
net.ipv4.ip_forward=1

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

/etc/network/interfaces:
up iptables-restore < /etc/iptables.ipv4.nat

sudo /etc/hostapd/hostapd.conf
interface=wlan0
bridge=br0
driver=nl80211
country_code=US
ssid=raspberry
hw_mode=g
channel=6
wpa=2
wpa_passphrase=MyPassword
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
auth_algs=1
macaddr_acl=0

/etc/init.d/hostapd restart

/etc/network/interfaces:
allow-hotplug wlan0
iface wlan0 inet static
address 10.0.2.1
netmask 255.255.255.0
auto eth0
iface eth0 inet static
    address 137.204.45.221
    netmask 255.255.255.0
    gateway 137.204.45.254
    dns-nameservers 8.8.8.8 8.8.4.4
pre-up iptables-restore < /etc/iptables.ipv4.nat

reboot
/etc/init.d/networking restart
/etc/init.d/hostapd restart
