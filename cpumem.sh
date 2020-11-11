#!/bin/bash

# print user
user=`ps u | grep 'ssh ubuntu@hunt-ukbb-iaas-theem bash' | head -n1 | cut -d ' ' -f1`

echo 'Currently '${user}' is running a GWAS'

echo 'Details can be found below'

# print time log
cat time.log

# print details from remote

tmp_dir=$(mktemp -d)
tmpfile=${tmp_dir}/psaux.txt

ssh ubuntu@hunt-ukbb-iaas-theem 'ps aux' > ${tmpfile}

(
  printf "%-8s\t%%CPU\t%%MEM\n" USER
  for u in `tail -n +2 ${tmpfile} | cut -d ' ' -f1 | sort -u` ; do
    res=`cat ${tmpfile} |grep "^${u} " | sed "s/  */ /g" | awk 'BEGIN{cpu=0 ; mem=0} {cpu+=$3; mem+=$4} END{print cpu/100"\t"mem}'`
    printf "%-8s\t${res}\n" $u
  done |grep -v -P "\t0\t0$" | sort -g -k2

  res=`tail -n +2 ${tmpfile} | sed "s/  */ /g" | awk 'BEGIN{cpu=0 ; mem=0} {cpu+=$3; mem+=$4} END{print cpu/100"\t"mem}' `
  printf "%-8s\t${res}\n" total
)

rm ${tmpfile}
rmdir ${tmp_dir}


