#!/bin/bash

if [[ -e ../image/SPL ]]
then
echo "[Copy SPL]"
flash_erase /dev/mtd0 0 192
dd if=../image/SPL of=/dev/mtd0 bs=512 seek=2 1>/dev/null 2>/dev/null;sync
sync
else
echo "SPL did bot exist"
fi

echo "[Done]"

