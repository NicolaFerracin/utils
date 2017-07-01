#!/bin/bash
echo -en "\n"
echo "Welcome!"
echo -en "\n"
echo "This script allows you to rename all files in a given directory to incremental numbers, based on the amount of files present."
echo -en "\n"
echo "Examples:"
echo "- 10 files will be renamed from 01.xx to 10.xx"
echo "- 100 files will be renamed from 001.xx to 100.xx"
echo "... and so on."
echo -en "\n"
echo "IMPORTANT NOTE: the files will only be renamed, not copied. To avoid bad surprises, use this script only after doing a backup of your files."
echo -en "\n"

read -p "Enter the directory: " -i "$HOME/" -e DIR

FILES=$(ls $DIR* -1 | wc -l)
DIGITS=${#FILES}
FORMATTER=%0${DIGITS}d
I=1
for F in $DIR*.*; do
  EXTENSION=${F##*.}
  if [ -z $EXTENSION ]; then
      echo "$(basename "$F") will be renamed to" `printf $FORMATTER $I`
  else
      echo "$(basename "$F") will be renamed to" `printf $FORMATTER.$EXTENSION $I`
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
    EXTENSION=${F##*.}
    if [ -z $EXTENSION ]; then
      mv "$F" `printf $DIR/$FORMATTER $I` 2>/dev/null || true
    else
      mv "$F" `printf $DIR/$FORMATTER.$EXTENSION $I` 2>/dev/null || true
    fi 
    I=$((I + 1))
  done
  echo "Renaming completed with success!"
  exit 0
else
  exit 0
fi
