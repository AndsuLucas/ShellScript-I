#! /usr/bin/env bash

########################################################################################
# Read notes from the database file corresponding of the pattern passing via parameter #
########################################################################################
readNote() {
    local PATTERN="$1"
    if [ "$PATTERN" = "--today" ]
    then
        #TODO...
        echo "todo.."
    fi

    local HAS_REGISTERS
    while read register; do
        HAS_REGISTERS=1
        getContent "$register"
    done < <(grep "${PATTERN//[-]/'\-'}" $DATABASE_FILE)
    
    if [ -z "$HAS_REGISTERS" ]
    then
        echo "Empty registers"
        exit
    fi

    makeTemplate
}