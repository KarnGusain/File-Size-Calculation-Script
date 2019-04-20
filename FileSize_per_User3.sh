#!/bin/bash
printf "\n"
printf "File-system Reporting For /home/karn  Mount\n"
printf "_____________________________________________\n"
printf "\n"
FILE="/tmp/logs.txt"
/bin/find /home/karn/ -xdev -size +1M -exec ls -aGl {} \; >> "$FILE"
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
