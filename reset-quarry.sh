#!/bin/bash

source quarry-list.sh

for turtle in "${quarrys[@]}"; 
do
    rm $turtle/OreQuarryLocation.txt
    rm $turtle/OreQuarryParams.txt
    rm $turtle/OreQuarryReturn.txt
    rm $turtle/resume.txt
done
