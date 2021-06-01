# HOW TO USE
# Keep all the images to sort in /imgs
# Make sure you back them up as this script will move, not copy them

FILES="imgs/*"
for f in $FILES
do
  ar=$(identify -format "%wx%h" "$f" | awk '{split($0,a,"x"); printf "%0.1f",a[1]/a[2]}')
  arDirName="ar-$ar" 
  [ ! -d $arDirName ] && mkdir $arDirName
  mv "$f" $arDirName
done
