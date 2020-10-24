#! /usr/bin/env bash

##########################
# Add a note on database #                                       
##########################
addNote() {
    printf "\n Type your note:"
    read
    local CONTENT="${REPLY}"
    if  [ "${#CONTENT}" -eq 0 ] 
    then
        printf "\n Empty text is not allowed."
        exit 1
    fi

    handleTimeInput()  {        
        if [ -z "$VALID_DATE" ]; then
            unset VALID_DATE
            printf "\n The date is not valid"
            exit 1
        fi 

        [[ $INITIAL_DATE =~ _ ]] && SEPARATOR=1

        if [ ! -z "$SEPARATOR" ] && [ -z ${EXPLODED_DATE[1]} ];
        then
            unset SEPARATOR
            printf "Have a separator but have'nt a hour"
            exit 1
        fi

        if [ -z "$VALID_HOUR" ] && [ ! -z ${EXPLODED_DATE[1]} ]; then
            unset VALID_HOUR
            printf "\n The hour is not valid"
            exit 1
        fi
    }    
    
    local INITIAL_DATE=""
    handleDateParams() {
        if [ "$1" = "--initial" ] || [ "$1" = "-i" ]
        then
            shift;
            
            INITIAL_DATE=$1
            read -a EXPLODED_DATE <<< $(explodeDateAndHour $1 "@")            
            validateDateAndHour ${EXPLODED_DATE[0]} ${EXPLODED_DATE[1]}
            handleTimeInput
    
            return 0
        fi

        INITIAL_DATE=$(getActualDate)
        return 0
    }

    handleDateParams $@

    local MUST_SAVE=""
    while [ "$MUST_SAVE" != "Y" ] && [ "$MUST_SAVE" != "N" ];
    do
        printf "\nSave this note? -> ${INITIAL_DATE}: ${CONTENT} \n"
        printf "\n(Y/N):"
        read
        MUST_SAVE="${REPLY^^}"
    done

    if [ "$MUST_SAVE" = "N" ]
    then
        printf "\nOperation abort!"
        exit 1
    fi

    saveContent "${INITIAL_DATE};${CONTENT}"
}