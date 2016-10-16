#!/usr/bin/env bash
set -e

command=''
while IFS='' read -r line || [[ -n "$line" ]]; do
    command="$command $line"
done < secrets.txt
command="$command rails s"
bash -c "$command"
