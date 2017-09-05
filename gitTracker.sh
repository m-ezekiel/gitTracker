#!/bin/bash
# File: gitTracker.sh
# Desc: Script to create time log entries based on command line working directories.


while true; do

    # Get current directory suffix
    export currentDir=`cat $HOME/.bash_history | grep cd | tail -n 1 | awk '{print $2;}' | sed 's/Documents\///'`

    # Check for gitFile
    if [ -a $HOME/Documents/$currentDir.git ]

        # Define inDate and inTime
        export inDate=`date | awk '{print $1 " " $2 " " $3 ", " $6;}'`
        export inTime=`date | awk '{print $4;}'`
        export startTime=`date +%s`

        then

        # While directory remains the same, do nothing.
        while [ "$prevDir" == "$currentDir" ]; do
            export currentDir=`cat $HOME/.bash_history | grep cd | tail -n 1 | awk '{print $2;}' | sed 's/Documents\///'`
            sleep 60
        done

        # Define outDate and outTime
        export outDate=`date | awk '{print $1 " " $2 " " $3 ", " $6;}'`
        export outTime=`date | awk '{print $4;}'`
        export endTime=`date +%s`

        # Runtime
        export runTime=$((endTime-startTime))

        # Write data to logfile
        echo "    $inDate   $inTime - $outTime      $runTime   $prevDir" >> $HOME/bin/logfile

    fi

    sleep 10

    export prevDir="$currentDir"
done

