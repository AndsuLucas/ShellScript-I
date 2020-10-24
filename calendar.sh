#! /usr/bin/env bash

#################################
#           DEPENDENCE:         #    
#################################
. ./config/globalVariables.sh   #
. ./services/dataManager.sh     #
. ./services/dateManager.sh     #
#################################

#################################
# Set Essentials configurtions  #
#################################
setCalendarDataBase             #
#################################

# Run the program
while test $#; 
do
    case "$1" in
        -a|--add)
            shift;
            . ./useCases/Note/addNote.sh
            addNote $@
        ;;
        -r|--read)
            shift
            . ./useCases/Note/readNote.sh 
            readNote $@
        ;;
        *)  
            break;
        ;;
    esac
done