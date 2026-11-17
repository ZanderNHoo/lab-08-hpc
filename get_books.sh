#!/bin/bash
set -euo pipefail

bucket=$1
book_dir=$2

mkdir -p "$book_dir"

aws s3 cp s3://$bucket/ "$book_dir" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt

find "$(realpath "$book_dir")" -name "*.txt" | sort >> book_list.txt
count=$(( $(wc -l < book_list.txt) - 1 ))

echo "Wrote $count book files to book_list.txt"
