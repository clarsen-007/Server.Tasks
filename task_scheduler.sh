#!/usr/bin/env bash

   ###   This application starts, manages and downloads application to run general tasks...

   ###   Variables

VERSION=00.01.00.01
TEMPFOLDER=/tmp
MEMTEMP=/var/run
APPFOLDER=/opt/clstools/bin
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

   ###   End Pre Tasks

   ###   Application start

VERIFY_VERSION() {

   $( which wget ) $SCRIPTPATH -P $TEMPFOLDER/

   if [[ "$VERSION" == "$( cat /tmp/task_scheduler.sh | grep 'VERSION=' | cut -d '=' -f2 | grep -Ev '^$' | $( which tr ) -d '[:blank:]' )" ]]
     then
     else
        echo -e " \n "
        echo -e " Version is outdated...  Configuring new version."
        echo -e " \n "
        mv $TEMPFOLDER/task_scheduler.sh $APPFOLDER/
        $( which chown ) root:root $APPFOLDER/task_scheduler.sh
        $( which chmod ) +x $APPFOLDER/task_scheduler.sh
        $APPFOLDER/task_scheduler.sh
   fi
}

VERIFY_VERSION

   ###   Application end

   ###   Cleanup

exit 0

###########################33
## Version 00.01.00.01
## Release version
