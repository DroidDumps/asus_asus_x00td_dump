#!/system/bin/sh
#savelogs_prop=`getprop persist.asus.savelogs`

#if [ ".$savelogs_prop" == ".0" ]; then

am broadcast -a "com.asus.removelogs.completed"
