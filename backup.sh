#!/bin/bash

homeDir=`echo ~`
backupDir="${homeDir}/.backup"

backup () {
    currentTime=`date '+%Y%m%d_%H%M%S'`
    for path in $@
    do
        if [ -e $path ]; then
            if [ ! -e $backupDir ]; then
                mkdir "${backupDir}"
            fi
            if [ ! -e $backupDir"/"$currentTime ]; then
                mkdir "${backupDir}/${currentTime}"
            fi
            parentDir=${path%/*}
            mkdir -p "${backupDir}/${currentTime}${parentDir}"
            cp -r $path "${backupDir}/${currentTime}${parentDir}"
            echo "backuped in ${backupDir}/${currentTime}${parentDir} "
        else
            echo "${path} is not exist. Absolute path required."
        fi
    done
}


if [ $# -eq 0 ]; then
    echo "Usage: backup files"
else
    backup $@
fi