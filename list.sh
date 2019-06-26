#!/bin/bash

##################################################
#
# list.sh
#   copyright 2019.06.25 konoar
#
##################################################

read -d '' scr <<END
{
	n = split(\$9, a, "/");
	s = a[n]; gsub(/\\\\./, "_", s);
	printf("KSDATA(%16s, %6d, %16s)\\\\n",
		s, \$5, "\\\\"" a[n] "\\\\"");
}
END

for file in `ls -1d data/*`; do
	if [ -f ${file} ]; then
		ls -l ${file} | awk "${scr}"
	fi
done

