#!/bash/bin

SOURCE_DIR=/c/Users/91915/rams/Shellscript/Shellscript/logs

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ -d $SOURCE_DIR ]
then
   echo -e " $SOURCE_DIR $R  Exist $N"
else
   echo -e "$SOURCE_DIR $G  Doest not Exits $N"
    exit 1
fi 

FILES=$(find $SOURCE_DIR -name "*.logs" -mtime +14)
   echo "files :$FILES"

while IFS= read -r line
do 
  echo "Deleting line :$line"
  rm -rf $line

done <<< $FILES