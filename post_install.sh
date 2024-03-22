#!/usr/bin/env bash

renesas_rl78_arduino_core_rules () {
    echo ""
    echo "# Renesas RL78 Arduino UDEV rules"
    echo ""
cat <<EOF
ACTION=="add", KERNEL=="ttyUSB*", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", GROUP="dialout", MODE="0666", RUN+="/bin/sh -c 'echo 5 > /sys/bus/usb-serial/devices/$kernel/\latency_timer'"
EOF
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

renesas_rl78_arduino_core_rules > /etc/udev/rules.d/99-renesas-rl78-arduino.rules

# reload udev rules
echo "Reload rules..."
udevadm trigger
udevadm control --reload-rules
