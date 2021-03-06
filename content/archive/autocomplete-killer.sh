#!/bin/bash
# a simple script to destroy autocomplete in linux installations. 
# Here's the process:
# 1. Try to identify each version of nsLoginManager.js
#    1.1 Some methods for this are to use locate, look in places we expect to find it, ask the user, search for it with find
#    1.2 Locate only updates about once a day, so not useful. Better to look where we expect it to be. Asking the user could work too, as could finding it.
# 2. For each one, ask the user if they want to change it.
# 3. If yes, change it. If no, don't.



##############
# We begin with our functions, it's not efficient, but it works
##############

# a function to print the help message.
function printHelp {
cat <<EOF
NAME
    autocompleteDestroyer.sh

SYNOPSIS
    autocompleteDestroyer.sh [ --find | --default | --help | --locate | --dictate ] 

OPTIONS
    This program will find the nsLoginManager.js file on your computer, and will fix it so that autocomplete is disabled in your installation of Firefox. Since this program will be altering your installation of Firefox, it will require your root password. 

    --help     Print this help file

    --default  Attempt to use the default location of the files (/usr/lib/xulrunner*/components/nsLoginManager.js)

    --locate   Use the locate database, if installed, to find the files. This will only find the files that were added before the last time the locate database was updated (which is typically once a day). It is faster than the --find option, but might not find all versions.

    --find     Use the find command to locate the nsLoginManager.js files. This will search in /usr/lib by default. Edit the script if you would like to change this. This is the slowest, but most thorough option.

    --dictate  Allows input of a known location.

EXIT STATUS
    autocompleteDestroyer.sh exists with a status of 0 if it encounters no problems. An exit status of 1 means incorrect usage. An exit status of 2 indicates it was unable to find your files. An exit status of 3 indicates the user terminated the program. An exit status of 4 means it encountered problems editing your file.

BUGS
    If any bugs are encountered, please see http://michaeljaylissner.com/contact

AUTHOR AND COPYRIGHT
    This script was authored by Michael Lissner and is released under GNU GPLv3.

EOF
}

# takes an argument, and creates an array containing the files to be modified.
function identifyEvilFiles {
    if [ $1 == "find" ]
    then
        files=$(find /usr/lib -name nsLoginManager.js 2> /dev/null)
        if [[ ! $files ]]
        then
            # Test if files has been set.
            echo "autocompleteDestroyer.sh: No files found. Try loosening the find parameter in the script, per the help file."
            exit 2
        fi
    elif [ $1 == "default" ]
    then
        # We assume the default location of nsLoginManager.js
        files=$(ls /usr/lib/xulrunner*/components/nsLoginManager.js 2> /dev/null)
        if [[ ! $files ]]
        then
            # We didn't have any hits. Exit.
            echo "autocompleteDestroyer.sh: We didn't find anything at the default locations. Perhaps try the --locate or --find arguments."
            exit 2
        fi
    elif [ $1 == "locate" ]
    then
        # We run the locate command, see if we have any hits.
        files=$(locate -b '\nsLoginManager.js' 2> /dev/null)
        if [[ ! $files ]]
        then
            # No hits. Exit.
            echo "autocompleteDestroyer.sh: We didn't find anything using the locate command. Perhaps try the --find argument."
            exit 2
        fi
    elif [ $1 == "dictate" ]
    then
        # "Why don't you just tell me what movie you'd like to see?" --Kramer.
        read -p "Where is the file nsLoginManager.js located on your machine: " files
        if [ -f $files ]
        then
            # Good. The file exists. We press on.
            echo "Thank you. That file exists, and we will modify it."
        else
            echo "autocomplete.sh: That file doesn't seem to exist. Please try again."
            exit 2
        fi
     fi
}



function modifyFiles {
    echo  "The following files will be modified: 
$files "
    echo 
    read -p "Shall we proceed (y/n): " proceed

    if [ $proceed == "y" -o $proceed == "Y" ]
    then
        # Here we go!
        while read -r line
        do
            echo Now processing $line
            #find the function in the file, label it with FILLERWORD, then replace the first line, and delete the rest. A messy approach, but functional
            sed -i.bak '/[[:space:]]*_isAutocompleteDisabled[[:space:]]*:[[:space:]]*function.*{[[:space:]]*$/,/^[[:space:]]*},[[:space:]]*$/s/^/FILLERWORD/' $line
            sed -r -i 's/FILLERWORD.*_isAutocomplete.*/    _isAutocompleteDisabled :  function (element) { return false; },/' $line
            sed -i '/FILLERWORD/d' $line

            # test if it worked
            grep -i -q 'isautocompletedisabled.*return false' $line
            if [ $? != 0 ]
            then
                # something failed...probably. Tell the user
                echo "Unable to successfully edit the file. Exiting"
                exit 4
            fi
        done <<< "$files"
        echo "All the files have been processed properly. Please restart Firefox, and thanks for using this script."
        exit 0
    else
        # It appears they'd like to abort. Let's exit.
        echo "OK. You know what to do if you change your mind."
        exit 3
    fi

}


#initiation sequence
if [ $# -eq 0 -o $# -gt 1 ]
then 
    # We need to give them help using the program. 
    echo "autocompleteDestroyer.sh:  Invalid number of arguments."
    echo "Usage: autocompleteDestroyer.sh [ --help | --default | --locate | --find | --dictate ] "
    exit 1
elif [[ $EUID -ne 0 ]]; 
then
    echo "autoCompleteDestroyer.sh: This script must be run as root" 1>&2
    exit 1
else
    case $1 in
        --help) printHelp;;
        --find) identifyEvilFiles find; modifyFiles;;
        --default) identifyEvilFiles default; modifyFiles;;
        --locate) identifyEvilFiles locate; modifyFiles;;
        --dictate)identifyEvilFiles dictate; modifyFiles;;
        *) echo "autocompleteDestroyer.sh: Invalid argument. Try the --help argument."
           exit 1;
    esac
fi
