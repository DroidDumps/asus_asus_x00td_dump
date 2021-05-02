#!/system/bin/sh

#GENERAL_LOG
GENERAL_LOG=/data/media/0/logs/

mkdir -p $GENERAL_LOG/anr
mkdir -p $GENERAL_LOG/recovery
cp -rf /data/anr/* $GENERAL_LOG/anr/
cp -rf /cache/recovery/* $GENERAL_LOG/recovery/

am broadcast -a "com.asus.copyanr.completed"
