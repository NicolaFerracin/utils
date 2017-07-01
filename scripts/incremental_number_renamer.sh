#!/bin/bash
echo -en "\n"
echo "Welcome!"
echo -en "\n"
echo "This script allows you to rename all files with the given format in a given directory to incremental numbers, based on the amount of files present."
echo -en "\n"
echo "Examples:"
echo "- 10 jpg will be renamed from 01.jpg to 10.jpg"
echo "- 100 jpg will be renamed from 001.jpg to 100.jpg"
echo "... and so on."
echo -en "\n"
echo "IMPORTANT NOTE: the files will only be renamed, not copied. To avoid bad surprises, use this script only after doing a backup of your files."
echo -en "\n"

read -p "Enter the directory: " -i "$HOME/" -e DIR
read -p "Enter the file format - such as JPG, PNG, TXT... (case sensitive): " FORMAT

FILES=$(ls $DIR*.$FORMAT -1 | wc -l)
DIGITS=${#FILES}
FORMATTER=%0${DIGITS}d
I=1
for F in $DIR*.$FORMAT; do
  echo "$(basename $F) will be renamed to" `printf $FORMATTER.$FORMAT $I`
  I=$((I + 1))
done

read -p "Are you sure you want to rename these files? (Y/N) " -n 1 -r
echo -en "\n"

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Started renaming..."
  echo -en "\n"
  I=1
  for F in $DIR*.$FORMAT; do
    mv "$F" `printf $DIR/$FORMATTER.$FORMAT $I` 2>/dev/null || true
    I=$((I + 1))
  done
  echo "Renaming completed with success!"
  exit 0
else
  exit 0
fi
