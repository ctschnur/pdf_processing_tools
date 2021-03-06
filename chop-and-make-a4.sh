#!/bin/bash

# to run this script, install pdfjam

set -x
pagecount=$(pdfinfo "$1" | grep Pages | sed 's/[^0-9]*//')

echo pagecount: $pagecount

# convert every page individually to a4 pdf size
# (and thereby stretch/shrink each pdf page individually)
for i in $(seq 1 $pagecount)
do
    echo $i
    printf -v j "%05.f" $i
    pdfjam $1 $i --a4paper --outfile a4ed-${j}.pdf
done

# join the pdf together
echo joining the a4ed pages back together to one pdf
pdfjam a4ed-*.pdf -o a4ed-joined.pdf
