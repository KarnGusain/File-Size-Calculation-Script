# This is small awk snippet which takes the Files "$FILE" variable and "$FILE" gets the feed from find command 
# where it looks the file Size more than 1MB and list them with the all the information except the group.
# However, It sorts the file owner and based on that aggregats the size consumed by that particulat user 
# and displays that along and at the end summrises the total size consumed by all the users for the mount.
# Please visit the readme section for output Result example.
# This is Just another variation of the script "FileSize_per_User.sh" , this just incorporates a little add on feature
# to look for the Files specific between two Years, in this case ie ->  between 2002 - 2018 

#!/bin/sh
# File Path
FILE="/tmp/logs.txt"
/bin/find /data1 -xdev -size +1M -exec ls -aGl {} \; >> "$FILE"
echo ""
awk '$7 >= 2002 && $7 <= 2018 {
  sum[$3] += $4
}

END {

  for (i in sum) {
    printf "User %-22s Total Space consumed: %3.2f GB\n", i, sum[i]/2**30
    total += sum[i]
  }
  print "==========================================================="
  printf "Total Space consumed by All Users: %3.2f GB\n", total/ 2**30
  echo ""

}' $FILE

/usr/bin/unlink "$FILE"
