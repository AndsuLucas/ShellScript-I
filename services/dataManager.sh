#! /usr/bin/env bash
##################################################
# This file is responsible to handle system data #
##################################################

############################
# Set databasse of program #
############################
setCalendarDataBase() {
    if [ ! -f "$DATABASE_FILE" ];
    then
        > $DATABASE_FILE
    fi
}

#####################################
# Save the content on database file #
#####################################
saveContent() {
   echo "$1" >> "$DATABASE_FILE"
}

###############
# Get content #
###############
getContent() {
    IFS=";"
    read -a CONTENT <<< "$1"
    CONTENT_COUNT=$((CONTENT_COUNT + 1))
    setContentByType() {
        local TIME=$1 
        local CONTENT=$2
        declare -gA CONTENT_BY_TYPE
        CONTENT_BY_TYPE[__$TIME]+="@${CONTENT}"
    }

    setContentByType "${CONTENT[@]}"
}   

#################################
# Make a apresentation template #
#################################
makeTemplate() {
    for date in ${!CONTENT_BY_TYPE[@]};
    do
        local DATE_STRING=${date//[@]/"-"}
        echo "${DATE_STRING//[__]/''} :"
        echo "${CONTENT_BY_TYPE[$date]//[@]/$'\n'}"
        echo "--------------"
    done
    echo "total: ${CONTENT_COUNT}"
    echo "--------------"
    unset CONTENT_COUNT
    unset CONTENT_BY_TYPE
}