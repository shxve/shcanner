#!/bin/bash

cat <<EOF
Thank you for choosing SHcanner

This script scans the files present in the input directories recursively looking for patterns for sensitive information, such as keys, passwords, secrets, etc.
You can choose the type of scan to perform, based on the type of scan more or less specific datasets will be used.

EOF


read -r -p "Do you want to perform a quick scan? (y/n): " scan_type

if [[ $scan_type == "y" ]]; then
    yaml_file="./patterns/merged_fast.yml"

elif [[ $scan_type == "n" ]]; then
    yaml_file="./patterns/merged_slow.yml"

else
    yaml_file="./patterns/merged_fast.yml"

fi

if [ ! -f "$yaml_file" ]; then
    echo "[!] Error: YAML file '$yaml_file' not found." >&2
    exit 1
fi

patterns=$(yq e '.patterns[] | "\(.pattern.name)#\(.pattern.regex)"' "$yaml_file")

mkdir -p ./results

output_file="./results/$(date +"%H%M%S")_result.txt"

read -r -p "Enter the folders to search (separated by space): " folders_input

IFS=' ' read -r -a folders <<< "$folders_input"

for folder in "${folders[@]}"; do
    if [ ! -d "$folder" ] || [ ! -r "$folder" ]; then
        echo "[!] Error: Folder '$folder' either does not exist or is not accessible." >&2
        exit 1
    fi
done


search_patterns() {
    local pattern="$1"
    local name="$2"
    local folder="$3"

    local result=$(find "$folder" -type f -exec grep -n -H -E --color=never "$pattern" {} + 2>/dev/null)
    if [ -n "$result" ]; then
        echo "Found $name in $folder:" >> "$output_file"
        echo "$result" | sed "s|^|$folder:|" >> "$output_file"
        echo >> "$output_file"
    fi
}


for folder in "${folders[@]}"; do
    while IFS="#" read -r name regex; do
        search_patterns "$regex" "$name" "$folder"
    done <<< "$patterns"
done

hits=$(wc -l < "$output_file")

echo "Scan completed. Found $((hits / 3)) occurrences. Results saved in: $output_file"
