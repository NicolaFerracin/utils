#!/bin/bash
echo -en "\n"
echo "Welcome!"
echo -en "\n"
echo "Given a directory, this script adds a given suffix to all file names in a given range."
echo -en "\n"
echo "IMPORTANT NOTE: the files will only be renamed, not copied. To avoid bad surprises, use this script only after doing a backup of your files."
echo -en "\n"

read -p "Enter the directory: " -i "$HOME/" -e DIR
IFS= read -r -p "Enter the suffix: " SUFFIX
echo "Using a lexicographically order..."
read -p "Start from file number: " START
read -p "Until and included file number: " END

I=1
for F in $DIR*.*; do
    if [ $I -ge $START ] && [ $I -le $END ]; then 
        EXTENSION=${F##*.}
        FILENAME=$(basename "$F")
        if [ -z $EXTENSION ]; then
            echo "$FILENAME will be renamed to" `printf "$FILENAME$SUFFIX"`
        else
            echo "$FILENAME will be renamed to" `printf "${FILENAME%.$EXTENSION}$SUFFIX.$EXTENSION"`
        fi
    fi
    I=$((I + 1))
done

read -p "Are you sure you want to rename these files? (Y/N) " -n 1 -r
echo -en "\n"

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Started renaming..."
    echo -en "\n"
    I=1
    for F in $DIR*.*; do
        if [ $I -ge $START ] && [ $I -le $END ]; then 
            EXTENSION=${F##*.}
            if [ -z $EXTENSION ]; then
                mv "$F" "$F$SUFFIX"
            else
                mv "$F" "${F%.$EXTENSION}$SUFFIX.$EXTENSION"
            fi 
        fi  
        I=$((I + 1))
    done
    echo "Renaming completed with success!"
    exit 0
else
  exit 0
fi
