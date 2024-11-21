#!/usr/bin/env bash

   ###   This application starts, manages and downloads application to run general tasks...

   ###   Variables

VERSION=00.01.00.01
TEMPFOLDER=/tmp
MEMTEMP=/var/run
LOG=/var/log
SCRIPTPATH=https://raw.githubusercontent.com/clarsen-007/Server.Tasks/refs/heads/main/task_scheduler.sh

   ###   Arguments

while getopts i:t:hv option
   do
      case "${option}"
         in
           i) NETWORKNAME=${OPTARG};;
           h) ;;
           v) ;;
      esac
done

if [[ "$@" == "-h" ]]
   then
     echo -e " \n "
     echo -e " Usage: task_scheduler.sh             [ -h Show help text ] "
     echo -e "                                      [ -v Version info ] "
     echo -e " Only one argument accepted "
     echo -e " \n "
     exit 0
fi

if [[ "$@" == "-v" ]]
   then
     echo -e " \n "
     echo -e " Version is = $VERSION "
     echo -e " \n "
     exit 0
fi

   ###   Pre Tasks
   
$( which wget ) $SCRIPTPATH -P $TEMPFOLDER/

   ###   End Pre Tasks

   ###   Application start

RESTART_APP() {

   if [[ "$VERSION" == "-v" ]]
     then
        echo -e " \n "
        echo -e " Version is = $VERSION "
        echo -e " \n "
        exit 0
   fi
}

if [[ "$@" == "-i $NETWORKNAME" ]]
   then
     IMPLEMENT_INSTALL
     rm $MEMTEMP/sunserver.iptables.on.boot.txt
     exit 0
fi

   ###   Application start

   ###   No argument specified

echo -e " \n "
echo -e " -h for help "
echo -e " \n "

   ###   Cleanup

exit 0

###########################33
## Version 00.01.00.01
## Release version
