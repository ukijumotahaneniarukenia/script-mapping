#!/usr/bin/env bash

# - IN
# curl -fsL 'https://kotlinlang.org/docs/reference/java-interop.html#mapped-types' -o test.html

usage(){

cat <<EOS

Usage:

  CMD: $0 Kotlin-C

EOS

exit 0

}

OUTPUT_FILE_PREFIX=$1;shift;
OUTPUT_FILE_SUFFIX=tsv

if [ -z $OUTPUT_FILE_PREFIX ];then

  usage

fi

table_tag_cnt=$(cat test.html | pup '.typo-table' | grep -cP '<table')

seq 1 $table_tag_cnt | \

  while read n;do

    if [[ $n -eq 1 ]];then
      xpath_table=$(cat test.html | pup ".typo-table" | teip -Gog '\s(id|class|href).*?(?=>)' -- sed 's/.//g'| grep -vP '<code>|</code>|<a>|</a>|<strong>|</strong>' | html2 | grep -P '/html/body/table/(thead|tbody)/tr/(th|td)')

    else
      xpath_table=$(cat test.html | pup ".typo-table:nth-of-type($n)"| teip -Gog '\s(id|class|href).*?(?=>)' -- sed 's/.//g'| grep -vP '<code>|</code>|<a>|</a>|<strong>|</strong>' | html2 | grep -P '/html/body/table/(thead|tbody)/tr/(th|td)')

    fi

    table_thead_tag_cnt=$(echo "$xpath_table" | grep -Pc 'thead')

    echo "$xpath_table" |ruby -F -anle 'p case $F[1];when nil; "-";else;$F[1..$F.size-1].join("うんこ") end' | xargs -n$table_thead_tag_cnt | sed 's/ /\t/g' | sed 's/うんこ/ /g' >$OUTPUT_FILE_PREFIX-$(printf "%02d" $n).$OUTPUT_FILE_SUFFIX

  done
