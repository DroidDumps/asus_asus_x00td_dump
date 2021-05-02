#!/system/bin/sh

########################################################
# savelogs.sh sample code
########################################################
# Revise date: 20161018
# Autoher: Jaff
# Purpose: Unify log directory for different platform
########################################################



########################################################
# Folder and property configuration
########################################################
#MODEM_LOG
MODEM_LOG=/data/media/0/ASUS/LogUploader/modem
#MODEM_LOG=/sdcard/ASUS/LogUploader/modem
#TCP_DUMP_LOG
TCP_DUMP_LOG=/data/media/0/ASUS/LogUploader/TCPdump
#TCP_DUMP_LOG=/sdcard/ASUS/LogUploader/TCPdump
#GENERAL_LOG
GENERAL_LOG=/data/media/0/ASUS/LogUploader/general/sdcard
#GENERAL_LOG=/sdcard/ASUS/LogUploader/general/sdcard
#Dumpsys folder
#DUMPSYS_DIR=/data/media/0/ASUS/LogUploader/dumpsys
#BUGREPORT_PATH=/data/user_de/0/com.android.shell/files
BUGREPORT_PATH=/storage/emulated/0/logs/aplog/Bugreports

savelogs_prop=`getprop persist.asus.savelogs`
memdumpenable=`getprop sys.asus.memdump`
is_tcpdump_status=`getprop init.svc.tcpdump-warp`



########################################################
# Save general logs
########################################################
save_general_log() {
	# save cmdline
	cat /proc/cmdline > $GENERAL_LOG/cmdline.txt
	echo "cat /proc/cmdline > $GENERAL_LOG/cmdline.txt"	
	# save mount table
	cat /proc/mounts > $GENERAL_LOG/mounts.txt
	echo "cat /proc/mounts > $GENERAL_LOG/mounts.txt"
	# save getenforce
	getenforce > $GENERAL_LOG/getenforce.txt
	echo "getenforce > $GENERAL_LOG/getenforce.txt"
	# save property
	getprop > $GENERAL_LOG/getprop.txt
	echo "getprop > $GENERAL_LOG/getprop.txt"
	# save network info
	cat /proc/net/route > $GENERAL_LOG/route.txt
	echo "cat /proc/net/route > $GENERAL_LOG/route.txt"
	netcfg > $GENERAL_LOG/ifconfig.txt
	echo "ifconfig -a > $GENERAL_LOG/ifconfig.txt"
	# save software version
	echo "AP_VER: `getprop ro.build.display.id`" > $GENERAL_LOG/version.txt
	echo "CP_VER: `getprop gsm.version.baseband`" >> $GENERAL_LOG/version.txt
	echo "BT_VER: `getprop bt.version.driver`" >> $GENERAL_LOG/version.txt
	echo "WIFI_VER: `getprop wifi.version.driver`" >> $GENERAL_LOG/version.txt
	echo "GPS_VER: `getprop gps.version.driver`" >> $GENERAL_LOG/version.txt
	echo "BUILD_DATE: `getprop ro.build.date`" >> $GENERAL_LOG/version.txt
	# save load kernel modules
	lsmod > $GENERAL_LOG/lsmod.txt
	echo "lsmod > $GENERAL_LOG/lsmod.txt"
	# save process now
	ps >  $GENERAL_LOG/ps.txt
	echo "ps > $SAVE_LOG_PATH/ps.txt"
	ps -t -p > $GENERAL_LOG/ps_thread.txt
	echo "ps > $SAVE_LOG_PATH/ps_thread.txt"
	# save kernel message
	dmesg > $GENERAL_LOG/dmesg.txt
	echo "dmesg > $GENERAL_LOG/dmesg.txt"
	# copy data/tombstones to data/media
	ls -R -l /data/tombstones/ > $GENERAL_LOG/ls_data_tombstones.txt
	mkdir $GENERAL_LOG/tombstones
	cp /data/tombstones/* $GENERAL_LOG/tombstones/
	echo "cp /data/tombstones $GENERAL_LOG"	
	# copy Debug Ion information to data/media
	mkdir $GENERAL_LOG/ION_Debug
	cp -r /d/ion/* $GENERAL_LOG/ION_Debug/

    ################################################
	# Move logcat, kernel, main logs to $GENERAL_LOG
	################################################
	# sample to move logcat & radio
	#if [ -d "/data/misc/qti-logkit/shared-privileged" ]; then
	#	for x in kmesg Bootup-kmsg logcat Bootup-logcat
	#	do
			#stop $x
			#mv /data/misc/qti-logkit/shared-privileged/$x.txt /data/misc/qti-logkit/shared-privileged/$x.txt.0
	#		start $x
			#mv /data/logcat_log/$x.txt.* $GENERAL_LOG/logcat_log
	#		cp /data/misc/qti-logkit/shared-privileged/$x.txt $GENERAL_LOG
	#	done
	#fi
	
        # copy HQlogs
        mkdir $GENERAL_LOG/logcat_log/
        cp -r /data/media/0/logs/aplog/* $GENERAL_LOG/logcat_log/
        echo "cp /sdcard/logs/aplog/* $GENERAL_LOG/logcat_log/"
        cp -r /data/media/0/logs/aplog/logcat* $GENERAL_LOG/
        
        cat /data/media/0/logs/aplog/logcat* >> $GENERAL_LOG/ASUSEvtlog.txt

	# copy /asdf/ASUSEvtlog.txt to ASDF
	#cp -r /sdcard/asus_log/ASUSEvtlog.txt $GENERAL_LOG #backward compatible
	#cp -r /sdcard/asus_log/ASUSEvtlog_old.txt $GENERAL_LOG #backward compatible
	#cp -r /asdf/ASUSEvtlog.txt $GENERAL_LOG
	#cp -r /asdf/ASUSEvtlog_old.txt $GENERAL_LOG
	#cp -r /asdf/ASDF $GENERAL_LOG
	#echo "cp -r /asdf/ASUSEvtlog.txt $GENERAL_LOG"
	
	# copy WiFi info
	ls -R -l /data/misc/wifi/ > $GENERAL_LOG/ls_wifi_asus_log.txt
	cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/hostapd.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/hostapd.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG"
	
	# mv /data/anr to data/media
	ls -R -l /data/anr > $GENERAL_LOG/ls_data_anr.txt
	mkdir $GENERAL_LOG/anr
	cp /data/anr/* $GENERAL_LOG/anr/
	echo "cp /data/anr $GENERAL_LOG/anr/"
	
    date > $GENERAL_LOG/date.txt
	echo "date > $GENERAL_LOG/date.txt"

	# save dumpstate report
        echo "dumpstate -q > $BUGREPORT_PATH/dumpstate.txt"
        #dumpstate -q > $GENERAL_LOG/dumpstate.txt
        BUGREPORT_PATH=/data/user_de/0/com.android.shell/files/bugreports
        dumpstate -q -d -z -o $BUGREPORT_PATH/bugreports
        cp /storage/emulated/0/logs/aplog/dumpstate.txt  $GENERAL_LOG
        rm /storage/emulated/0/logs/aplog/dumpstate.txt
        cp -r /data/user_de/0/com.android.shell/files/bugreports/  $GENERAL_LOG
        rm -rf /data/user_de/0/com.android.shell/files/bugreports/*

	# Save microp_dump
        micropTest=`cat /sys/class/switch/pfs_pad_ec/state`
	if [ "${micropTest}" = "1" ]; then
	    date > $GENERAL_LOG/microp_dump.txt
	    cat /d/gpio >> $GENERAL_LOG/microp_dump.txt                   
        echo "cat /d/gpio > $GENERAL_LOG/microp_dump.txt"  
        cat /d/microp >> $GENERAL_LOG/microp_dump.txt
        echo "cat /d/microp > $GENERAL_LOG/microp_dump.txt"
	fi
	
	# Save df info
	df > $GENERAL_LOG/df.txt
	echo "df > $GENERAL_LOG/df.txt"
}



########################################################
# Save modem logs
########################################################
save_modem_log() {
	#mv /data/media/diag_logs/QXDM_logs $MODEM_LOG
        #cp -r /data/media/0/logs/diag_logs $MODEM_LOG
        cp -r /data/media/0/diag_logs $MODEM_LOG
	echo "cp -r /data/media/0/logs/diag_logs $MODEM_LOG"
}



########################################################
# Save TCPDump logs
########################################################
save_tcpdump_log() {
#	if [ -d "/data/logcat_log" ]; then
#		if [ ".$is_tcpdump_status" == ".running" ]; then
#			stop tcpdump-warp
#			start tcpdump-warp
#			for fname in /data/logcat_log/capture.pcap*
#			do
#				if [ -e $fname ]; then
#					if [ ".$fname" != "./data/logcat_log/capture.pcap0" ]; then
#						mv $fname $TCP_DUMP_LOG
#					fi
#				fi
#			done
#		else
#			mv /data/logcat_log/capture.pcap* $TCP_DUMP_LOG
#		fi
#	fi
        cp -r /data/media/0/logs/tcpdump $TCP_DUMP_LOG
	echo "cp -r /data/media/0/logs/tcpdump $TCP_DUMP_LOG"
}



########################################################
# Remove folders
########################################################
remove_folder() {
	# remove folder
	if [ -e $GENERAL_LOG ]; then
		rm -r $GENERAL_LOG
	fi
	
	if [ -e $MODEM_LOG ]; then
		rm -r $MODEM_LOG
	fi
	
	if [ -e $TCP_DUMP_LOG ]; then
		rm -r $TCP_DUMP_LOG
	fi
}



########################################################
# Create folders
########################################################
create_folder() {
	mkdir -p $GENERAL_LOG
	echo "mkdir -p $GENERAL_LOG"
	
	mkdir -p $MODEM_LOG
	echo "mkdir -p $MODEM_LOG"
	
	mkdir -p $TCP_DUMP_LOG
	echo "mkdir -p $GENERAL_LOG"
}



########################################################
# Main process
########################################################
if [ ".$memdumpenable" == ".1" ]; then
     mkdir -p mkdir /sdcard/logs/memdump
     local_time=`date '+%Y-%m-%d_%H:%M:%S'`
     /system/bin/dumpsys -t 30 meminfo > /sdcard/logs/memdump/meminfo_${local_time}.txt
     setprop sys.asus.memdump 0
     exit
fi

if [ ".$savelogs_prop" == ".0" ]; then
	remove_folder
	# Ack BugReporter

        setprop persist.asus.uts com.asus.removelogs.completed
        setprop persist.asus.savelogs.complete 1
        setprop persist.asus.savelogs.complete 0

        am broadcast -a "com.asus.removelogs.completed"
	
elif [ ".$savelogs_prop" == ".1" ]; then
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_general_log
	save_general_log
	
	# sync data to disk 
	chmod -R 777 $GENERAL_LOG
	sync
        setprop persist.asus.savelogs.dumpstate 0
        setprop persist.asus.savelogs.dumpstate 1
        setprop persist.asus.uts com.asus.savelogs.completed

	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
        am broadcast -n com.log.setlog/.DelelogReceiver -a "com.asus.savelogs.completed"
        am broadcast -n com.android.shell/.BugreportReceiver -a "com.android.internal.intent.action.BUGREPORT_COPY_FINISHED"
 	echo "Done"
	
elif [ ".$savelogs_prop" == ".2" ]; then
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save modem_log && general_log
	save_modem_log
	save_general_log

	# sync data to disk 
	chmod -R 777 $MODEM_LOG
	chmod -R 777 $GENERAL_LOG
	sync

        setprop persist.asus.uts com.asus.savelogs.completed
        setprop persist.asus.savelogs.complete 1
        setprop persist.asus.savelogs.complete 0

	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
        am broadcast -n com.log.setlog/.DelelogReceiver -a "com.asus.savelogs.completed"
 	echo "Done"
	
elif [ ".$savelogs_prop" == ".3" ]; then
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_tcpdump_log && general_log
	save_tcpdump_log
	save_general_log

	# sync data to disk 
	chmod -R 777 $TCP_DUMP_LOG
	chmod -R 777 $GENERAL_LOG
	sync
	
        setprop persist.asus.uts com.asus.savelogs.completed
        setprop persist.asus.savelogs.complete 1
        setprop persist.asus.savelogs.complete 0

	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
        am broadcast -n com.log.setlog/.DelelogReceiver -a "com.asus.savelogs.completed"
 	echo "Done"
	
elif [ ".$savelogs_prop" == ".4" ]; then
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_general_log && modem_log && tcpdump_log
	save_general_log
	save_modem_log
	save_tcpdump_log
	
	# sync data to disk 
	chmod -R 777 $GENERAL_LOG
	chmod -R 777 $MODEM_LOG
	chmod -R 777 $TCP_DUMP_LOG
	
        setprop persist.asus.savelogs.dumpstate 0
        setprop persist.asus.savelogs.dumpstate 1
        setprop persist.asus.uts com.asus.savelogs.completed

	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
        am broadcast -n com.log.setlog/.DelelogReceiver -a "com.asus.savelogs.completed"
 	echo "Done"
fi
