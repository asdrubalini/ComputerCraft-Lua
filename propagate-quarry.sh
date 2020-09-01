#!/bin/bash

declare -a quarrys=(12 13 14 15 21 16 40 24 27 28 29 30 31 32 33 34)

for turtle in "${quarrys[@]}"; 
do
    cp ./quarry.lua $turtle/quarry.lua
    cp ./quarry-startup.lua $turtle/startup.lua
    cp ./quarry-listen.lua $turtle/listen.lua
done
