#!/bin/bash

declare -a quarrys=(0 1 10 12 13 14 15 21 22 23 24 27 28 29 30 31 32 33 34)

for turtle in "${quarrys[@]}"; 
do
    cp ./quarry.lua $turtle/quarry.lua
done
