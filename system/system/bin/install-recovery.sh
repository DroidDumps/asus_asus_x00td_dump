#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery:56968492:395a7c328cdd70cd91c0ea3c3521c69dfe445e58; then
  applypatch --bonus /system/etc/recovery-resource.dat \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot:50738472:32fa98dcff2a35e285fae174ef944fd309d1c91e \
          --target EMMC:/dev/block/bootdevice/by-name/recovery:56968492:395a7c328cdd70cd91c0ea3c3521c69dfe445e58 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
