#!/usr/bin/env bash
set -eu

# grab the latest .deb filename from https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/
# and copy it here to update this script:
RASPI_CONFIG_DEB="raspi-config_20201108_all.deb"

if [ "$(whoami)" != "root" ]; then
  echo "Sorry, you are not root. You must type: sudo ./install.sh"
  exit 1
fi

if ! command -v apt-get ; then
  echo "This install script only works on Debian-derived distributions."
  exit 2
fi

if [ $(dpkg-query -W -f='${Status}' raspi-config 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
  echo "raspi-config is already installed. Try upgrading it within raspi-config."
  exit 3
fi

apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
apt-get install -fy

wget -O /tmp/raspi-config.deb https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/$RASPI_CONFIG_DEB
dpkg -i /tmp/raspi-config.deb

echo "raspi-config is now installed. Run it by typing: sudo raspi-config"
