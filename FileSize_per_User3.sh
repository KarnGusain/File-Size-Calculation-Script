    
# This is small awk snippet which takes the Files "$FILE" variable and "$FILE" gets the feed from find command 
# where it looks the file Size more than 1MB and list them with the all the information except the group.
# However, It sorts the file owner and based on that aggregats the size consumed by that particulat user 
# and displays that along and at the end summrises the total size consumed by all the users for the mount.
# Please visit the readme section for output Result example.
# This is Just another awk variant of the script!

#!/bin/bash
printf "\n"
printf "File-system Reporting For /home/karn  Mount\n"
printf "_____________________________________________\n"
printf "\n"
FILE="/tmp/logs.txt"
/bin/find /data1 -xdev -size +1M -exec ls -aGl {} \; >> "$FILE"
/bin/awk -vusrfmt="User %-30s Total Space consumed: %11.6f GB\n" \
         -vsumfmt=$( printf "=%.0s" {1..72} )"\nTotal Space consumed by All Users: %35.6f GB\n"  '
  {
    subtot[$3]+=$4;
    tot+=$4
  }
  END {
    for (u in subtot) printf usrfmt, u, subtot[u]  / 2**30
    printf sumfmt, tot / 2**30

  }' $FILE

/bin/unlink "$FILE"
