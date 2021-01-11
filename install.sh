#!/usr/bin/env bash
set -eu

if [ "$(whoami)" != "root" ]; then
  echo "This script must be run as root: sudo ./install.sh"
  exit 1
fi

if ! command -v apt-get ; then
  echo "This script only works on Debian-derived distributions."
  exit 1
fi

apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
apt-get install -fy

RASPI_CONFIG_DEB="$(curl -s https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/ | grep -E -o "raspi-config_\d\d\d\d\d\d\d\d_all.deb" | tail -n 1)"

echo ""
echo "Downloading & installing $RASPI_CONFIG_DEB ..."
echo ""

wget -O /tmp/raspi-config.deb "https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/$RASPI_CONFIG_DEB"
dpkg -i /tmp/raspi-config.deb
rm /tmp/raspi-config.deb

echo "raspi-config is now installed."
echo "Run it by typing: sudo raspi-config"
