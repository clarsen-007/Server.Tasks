#!/usr/bin/env bash

# This application starts, manages, and downloads an application to run general tasks.

# Variables
VERSION="00.01.00.01"
TEMPFOLDER="/tmp"
APPFOLDER="/opt/clstools/bin"
LOG="/var/log"
SCRIPTPATH="https://raw.githubusercontent.com/clarsen-007/Server.Tasks/refs/heads/main/task_scheduler.sh"

# Arguments
show_help() {
    echo -e "\nUsage: task_scheduler.sh [options]"
    echo -e "Options:"
    echo -e "  -h           Show help text"
    echo -e "  -v           Show version info"
    echo -e "  -i <name>    Specify network name (optional)"
    echo -e "\n"
    exit 0
}

while getopts "i:hv" option; do
    case "${option}" in
        i) NETWORKNAME="${OPTARG}";;
        h) show_help;;
        v) 
            echo -e "\nVersion: $VERSION\n"
            exit 0
            ;;
        *)
            show_help
            ;;
    esac
done

# Pre Tasks (Placeholder for any preparation steps)

# Application start
wget -q -O "$TEMPFOLDER/task_scheduler.sh" "$SCRIPTPATH"

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to download task_scheduler.sh from $SCRIPTPATH."
    exit 1
fi

DOWNLOADED_VERSION=$(grep '^VERSION=' "$TEMPFOLDER/task_scheduler.sh" | cut -d '=' -f2 | tr -d '[:blank:]')

if [[ "$VERSION" == "$DOWNLOADED_VERSION" ]]; then
    echo "Version is up to date."
else
    echo -e "\nVersion is outdated... Configuring new version.\n"
    mv "$TEMPFOLDER/task_scheduler.sh" "$APPFOLDER/"
    chown root:root "$APPFOLDER/task_scheduler.sh"
    chmod +x "$APPFOLDER/task_scheduler.sh"
    
    # Check if we are already in the updated script
    if [[ "$0" != "$APPFOLDER/task_scheduler.sh" ]]; then
        echo "Running updated version..."
        exec "$APPFOLDER/task_scheduler.sh" "$@"
    else
        echo "Update completed. Exiting."
    fi
    exit 0
fi

# Cleanup (Optional if you want to remove temp files)
rm -f "$TEMPFOLDER/task_scheduler.sh"

exit 0
