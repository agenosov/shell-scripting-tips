#!/bin/bash

# This script answers which SO file as a dependency for the passed binary caused this binary to be dependent from another SO file.
# Example: binary A depends from libxyz.so.
#          We want to find out through wich concrete binary this dependency exists.
#
bin_obj="$1"
dependency="$2"

tmp_file=$(mktemp)
ldd "$bin_obj" > "$tmp_file"

while read -r; do
    item_name=$(echo "$REPLY" | awk '{ print $1 }' | cut -d. -f1)
    if [ "$item_name" == "linux-vdso" ] ; then
        continue
    fi
    if [ "$item_name" == "/lib64/ld-linux-x86-64" ] ; then
        continue
    fi

    # It's necessary to extract exactly a path to SO, without an address.
    item_path=$(echo "$REPLY" | awk '{ print $3 }')
    
    echo "...Inspect dependencies for: $item_path"
    
    output=$(ldd "$item_path" | grep "$dependency")
    if [ -z "$output" ] ; then
        continue
    fi
    echo "$bin_obj depends from $dependency through $item_name:"
    echo "$output"
    echo

done < "$tmp_file"

rm "$tmp_file"
