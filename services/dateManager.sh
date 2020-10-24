#! /usr/bin/env bash

###################################################
# This file is ressponsible to handle date values #
###################################################

########################################################
# Transform contatenated string date and hour in array #
########################################################
explodeDateAndHour() {
    TIME_STRING=$1
    IFS=$2

    read -a EXPLODED_DATE <<< "$TIME_STRING"
    echo "${EXPLODED_DATE[@]}"
}

######################################################
# Validate if date and hour are with a valid pattern #
######################################################
validateDateAndHour() {
    [[ $1 =~ ^[0-9]{2}(\/|-)[0-9]{2}(\/|-)[0-9]{4}$ ]] && VALID_DATE=1
    [[ $2 =~ ^[0-9]{2}:[0-9]{2}$ ]] && VALID_HOUR=1
}

###################
# Get actual date #
###################
getActualDate() {
    NOW=$(date +"%d/%m/%Y@%H:%M")
    echo $NOW
}