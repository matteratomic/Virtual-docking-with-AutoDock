#! /bin/bash
#Written by Ian Ndeu Macharia
#initialize variables
mkdir -p ligands
cd ligands
ligands=($(echo ZINC*.pdbqt))
progress=0;
progress_log="./progress_log.txt"
results_file="./results.txt"
results_folder="./results"
cd ..
#Check progress of previous run
if [ -f "$progress_log" ]
then
((progress=`cat $progress_log | grep . || echo 0`))
echo "Starting screening from ligand $progress"
fi

#Loop through the ligands to perform docking
for f in "${ligands[@]:$progress}"; do
b=$(basename $f .pdbqt)
echo "Processing ligand $f"
mkdir -p $results_folder
vina.exe --num_modes 3 --config "conf.txt" --ligand "./ligands/$f" --out "./$results_folder/$f" --log "./$results_folder/$b.txt";

#increment progress counter
((progress++))
echo "$progress" > $progress_log
done

#Collect results and store to file
cd $results_folder
results=$(grep "   1 " *.txt | cut -c 22-24,1-13,32-42,44-53 | sort -rt" " +2)
echo "$results" > $results_file
echo "Ligand docking has completed"
