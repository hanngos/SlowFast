#!/bin/bash

# Check if args are valid
VALID_ARGS=$(getopt -o n:s: --long name:,split: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

# Read args
eval set -- "$VALID_ARGS"
while [ : ]; do
  case $1 in
    -n | --name)
        root_dir=$2
        shift 2
        ;;
	-s | --split)
        split=$2
        shift 2
        ;;
    -t | --test)
        t=true
        shift
        ;;
    --) shift; 
        break 
        ;;
  esac
done

# Enter root_dir
cd "$root_dir"

# List subdirectories
subdirectories=($(ls -d *))
#subdirectories=($(find . -maxdepth 1 -mindepth 1 -type d))

# Create classids file e.g.{ "Fight": 0, "NoFight": 1 }
echo "Creating classids.json file"
classids_json="{"
for ((i=0; i<${#subdirectories[@]}; i++)); do
    classids_json="$classids_json \"${subdirectories[$i]}\": $i,"
done
classids_json="${classids_json%,} }"
echo -e "$classids_json" > "./classids.json"

# Create train and val csv files 
echo "Creating train.csv and val.csv files"
for ((s=0; s<${#subdirectories[@]}; s++)); do
	videos=($(ls "${subdirectories[$s]}"/*))
	#videos=($(shuf -e "${videos[@]}"))

	num_of_videos=${#videos[@]}
	num_of_train=$(((num_of_videos*split*80) / 10000))
	num_of_val=$(((num_of_videos*(split*20)) / 10000))
    num_of_test=$(((num_of_videos*(100-split)) / 100))
    
    for ((i=0; i<$num_of_val; i++)); do
		val+=("${videos[$i]}")
		valids+=("$s")
        unset videos[$i]
	done
	for ((i=$num_of_val; i<($num_of_val+$num_of_train); i++)); do
		train+=("${videos[$i]}")
		trainids+=("$s")
		unset videos[$i]
	done
    for ((i=($num_of_train + $num_of_val); i<$num_of_videos; i++)); do
		test+=("${videos[$i]}")
		testids+=("$s")
        unset videos[$i]
	done
done

pwd=$(pwd)
#pwd=/slowfast/data/${root_dir}

# Write to files
echo "Writing to train and val to csv files"
if [ ${#train[@]} == ${#trainids[@]} ]; then
    for ((i=0; i<${#train[@]}; i++)); do
		echo -e "${pwd}/${train[i]},${trainids[i]}" >> "./train.csv"
	done
fi
shuf ./train.csv -o ./train.csv

if [ ${#val[@]} == ${#valids[@]} ]; then
    for ((i=0; i<${#val[@]}; i++)); do
		echo -e "${pwd}/${val[i]},${valids[i]}" >> "./val.csv"
	done
fi
shuf ./val.csv -o ./val.csv

echo "Writing to test to csv file"
if [ ${#test[@]} == ${#testids[@]} ]; then
    for ((i=0; i<${#test[@]}; i++)); do
        echo -e "${pwd}/${test[i]},${testids[i]}" >> "./test.csv"
    done
fi
shuf ./test.csv -o ./test.csv


echo "Done"