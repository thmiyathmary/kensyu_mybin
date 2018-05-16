#!/bin/bash

homeDir=`echo ~`
backupDir="${homeDir}/.backup"

restore () {
    for path in $@
    do
        if [ ! -e $backupDir ]; then
            echo "Backup directory is not exist."
        else
            findResults=($(find ${backupDir} -path "/*${path}"))
            i=0
            for result in ${findResults[@]}; do
                echo "[${i}]: "${result:${#backupDir}+1:15}
                let i++
            done
            echo "Please type the number or <enter> to exit > "
            read input
            if [ $input -ge 0 ] && [ $input -lt $i ]; then
                echo ${findResults[$input]}
                bash ./backup.sh $path
                rm -rf $path
                cp -r ${findResults[$input]} $path
            else 
                echo "Invalid input. "
            fi
        fi
    done
}


if [ $# -eq 0 ]; then
    # echo "Usage: restore files [date_from [date_to]]"
    echo "Usage: restore files"
else
    restore $@
fi