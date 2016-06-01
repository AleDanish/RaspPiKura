sudo chmod u+s /bin/ping
sudo apt-get update
sudo apt-get -y install resolvconf
 
sudo apt-get -y remove resolvconf

# Wifi hotspot setup
sudo apt-get update
bash conf_wifi_rasp

# Kura setup
sudo apt-get update
bash conf_kura_rasp

sudo reboot

#Ri-settare le tabelle di routing
#Ri-settare /etc/network/interfaces

sudo reboot
sudo /etc/init.d/kura start
