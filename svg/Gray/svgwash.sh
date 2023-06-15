#!/bin/bash
# SVG files cleaner 
# By Martín Belmonte 2022
# Lic: GPL v3
# svgcleaner

ls --recursive *.[Ss][Vv][Gg] | while read -r FILE
do
    svgcleaner "$FILE" "$FILE"
done

