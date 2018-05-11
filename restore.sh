#!/bin/bash

homeDir=`echo ~`
backupDir="${homeDir}/.backup"

restore () {
    for path in $@
    do
        if [ ! -e $backupDir ]; then
            echo "Backup directory is not exist."
        else
            findResults=`find ${backupDir} -path "/*${path}"`            
            echo $findResults
        fi
    done
}


if [ $# -eq 0 ]; then
    # echo "Usage: restore files [date_from [date_to]]"
    echo "Usage: restore files"
else
    restore $@
fi