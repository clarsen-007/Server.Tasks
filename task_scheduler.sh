#!/usr/bin/env bash

   ###   This application starts, manages and downloads application to run general tasks...

   ###   Variables

VERSION=00.01.00.01
TEMPFOLDER=/tmp
MEMTEMP=/var/run
LOG=/var/log

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

RESTART_APP() {

   if [[ "$VERSION" == "-v" ]]
     then
        echo -e " \n "
        echo -e " Version is = $VERSION "
        echo -e " \n "
        exit 0
   fi

   ### End of IMPLEMENT_INSTALL

}

if [[ "$@" == "-i $NETWORKNAME" ]]
   then
     IMPLEMENT_INSTALL
     rm $MEMTEMP/sunserver.iptables.on.boot.txt
     exit 0
fi

   ###   No argument specified

echo -e " \n "
echo -e " -h for help "
echo -e " \n "

   ###   Cleanup

exit 0

###########################33
## Version 00.01.00.01
## Release version
