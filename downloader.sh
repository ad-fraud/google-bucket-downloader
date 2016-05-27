#!/bin/bash

## F U N C T I O N S   S T A R T

prep_missing() {

seq -w 0 "$SEQHI" > retry.check
ls *csv* | rev | cut -d. -f3 | colrm 4 | rev | grep . > retry.temp
grep -vif retry.temp retry.check > retry.missing
}


test_missing() {

while read MISSING
	do
		gsutil -m cp "$FILEPATH"*"$MISSING".csv.gz .
done <retry.missing
}


## P R O G R A M   S T A R T

## reading variables 

read -p "Path to file : " FILEPATH
read -p "Number of files : " FILES

SEQHI=$(expr "$FILES" - 1)

## starting the dowload

gsutil -m cp "$FILEPATH"*.csv.gz .

rm *_.gstmp
prep_missing

while [[ -s retry.missing ]]
	do
		test_missing
		rm *_.gstmp
		prep_missing
done

## cleaning up and finishing 

FOLDER=$(echo "$FILEPATH" | cut -d/ -f4)
mkdir "$FOLDER"
mv *csv.gz "$FOLDER"
echo -e "$FOLDER \t DONE"

## P R O G R A M   E N D S
