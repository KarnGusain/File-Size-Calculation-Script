#!/bin/sh
# File_sizeCal_awk.sh
# File Path
FILE="/tmp/logs.txt"
# Find command to list the files above than 10MB size which excluded group.
FIND=$(/bin/find /data1 -xdev -size +10M -exec ls -aGl {} \; >> "$FILE")
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
