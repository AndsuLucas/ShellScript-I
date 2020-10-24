#! /usr/bin/env bash

########################################################################################
# Read notes from the database file corresponding of the pattern passing via parameter #
########################################################################################
readNote() {
    local PATTERN="$1"
    if [ "$PATTERN" = "--now" ]
    then
        IFS="@"
        local DATE=$(getActualDate)
        read -a EXPLODED_ACTUAL_DATE <<< "$DATE"
        echo "${EXPLODED_ACTUAL_DATE}"
        exit
        
    fi

    local REGISTERS=$(grep "${PATTERN//[-]/'\-'}" $DATABASE_FILE)
    if [ -z "$REGISTERS" ]
    then
        echo "Empty registers"
        exit
    fi

    for i in "$REGISTERS";
    do
        getContent "$i"
    done

    makeTemplate
}