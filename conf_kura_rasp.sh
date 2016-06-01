
# Java setup ???
sudo apt-get install oracle-java8-jdk

# sudo nano /etc/profile: ???
export JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm32-vpf-hflt
export PATH=$JAVA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/arm


# Kura dependencies
sudo apt-get update
sudo apt-get -y install bind9 isc-dhcp-server iw monit dos2unix telnet unzip

# Kura install
wget https://s3.amazonaws.com/kura_downloads/raspbian/release/1.4.0/kura_1.4.0_raspberry-pi-bplus_installer.deb -P /tmp
sudo dpkg -i /tmp/kura_1.4.0_raspberry-pi-bplus_installer.deb


