#!/bin/bash

source quarry-list.sh

for turtle in "${quarrys[@]}"; 
do
    cp ./quarry.lua $turtle/quarry.lua
    cp ./quarry-startup.lua $turtle/startup.lua
    cp ./quarry-listen.lua $turtle/listen.lua
done
