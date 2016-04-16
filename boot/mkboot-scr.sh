#!/bin/bash
# This script generates the boot.scr file from a boot.script file.
# U-Boot can then use that boot.src file in order to boot the system.
#
# TFTPd should provide: `filename "path/to/boot.scr";'
# U-boot should set env: `bootcmd=dhcp; source 0x90000000'

SCRIPT=$1
if [ -z "$SCRIPT" -a "${SCRIPT##*.}" != "script" ]; then
  echo "give a boot script" 1>&2
  exit 1
fi
mkimage -A arm64 -O linux -T script -C gzip -a 0x90000000 -e 0x90000000 -d $SCRIPT -n "arm64-nfsroot" ${SCRIPT%.script}.scr
