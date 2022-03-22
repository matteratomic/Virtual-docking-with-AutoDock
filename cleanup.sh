#!/bin/bash
rm progress_log.txt 2>/dev/null

while getopts ":d" option;
do
      case $option in
         d) #Delete ligands 
            echo Deleting ligands
            rm -rf ./ligands;;
      esac
done
