# This is small awk snippet which takes the Files "$FILE" variable and "$FILE" gets the feed from find command 
# where it looks the file Size more than 1MB and list them with the all the information except the group.
# However, It sorts the file owner and based on that aggregats the size consumed by that particulat user 
# and displays that along and at the end summrises the total size consumed by all the users for the mount.
# Please visit the readme section for output Result example.

#!/bin/sh
# File_sizeCal_awk.sh
#
echo "File-system Reporting For /home/jake Mount"

FILE="/tmp/logs.txt"
/bin/find /home/jake -xdev -size +1M -exec ls -aGl {} \; >> "$FILE"
echo ""

awk '{
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

/bin/unlink "$FILE"
