#! /system/bin/sh
#mkdir /sdcard/aplog/anr
#mkdir  /sdcard/aplog/tombstones
anrlogname="anr_"$(date +"%Y-%m-%d_%H-%M-%S")
tomblogname="tombstone_"$(date +"%Y-%m-%d_%H-%M-%S")
screenshotname="screenshot_tombstone_"$(date +"%Y-%m-%d_%H-%M-%S")

loglocation=`getprop sys.log.location`
aplogpath="/sdcard/logs/aplog"

case "$loglocation" in
    "1")
    aplogpath="/sdcard/logs/aplog"
    ;;
    "0")
    aplogpath="/sdcard/logs/aplog"
    ;;
    *)
    aplogpath="/sdcard/logs/aplog"
    ;;
esac
#mkdir -p  $aplogpath
cat /data/tombstones/* > $aplogpath/$tomblogname.txt
#screencap -p $aplogpath/$screenshotname.png
