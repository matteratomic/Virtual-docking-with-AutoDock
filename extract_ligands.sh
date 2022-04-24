#! /bin/bash
#Written by Ian Ndeu Macharia
#Command to extract multiple ligands and convert them into pdbqt file format
#for use in docking with AutoDock Vina

mkdir -p ligands
obabel -isdf pharmacophore_query_results.sdf -o pdbqt -O ./ligands/lig.pdbqt -m

#Rename files to match Drug ID from ZINC15 database
cd ligands
arr=($(ls | grep .pdbqt | tr "\n" " "))
echo "Renaming files. Please wait..."
echo "Files are ${#arr[@]}"
#sleep 5
for i in "${arr[@]}"; do
  name=$(grep "Name =" $i | awk -F" " '{print $4}')
   if [ ! -f "$name.pdbqt" ]
	then
	echo "Renaming $i to $name.pdbqt"
        mv "$i" $name.pdbqt
	else
	#Remove possible duplicate conformer
	rm "$i"
   fi
done
echo 'Ligands have been renamed'
