#!/bin/bash

# This is an example of how to organize processing of command line options,
# in order to get rid of just passing list of args without knowing what each of them really means

# Assume we want to accept one option as a flag for something and also an option with some value,
# so the script is expected to be launched as: <THIS_SCRIPT> -d <SOME_PATH> -v
#
# So above the 1-st option (-d) assist to pass a value for itself and the 2-nd option is just a flag

is_verbose=false

while getopts "d:v" opt
do
    case $opt in
        d)
            input_dir="$OPTARG"
            ;;
        
        v)
            is_verbose=true
            ;;

        \?)
            echo "Invalid option -$OPTARG"
            exit 1
            ;;

        :)
            echo "Error: Option -$OPTARG requires an argument"
            exit 1
            ;;
    esac
done

if [ ! -z "$input_dir" ] ; then
    echo "input dir: $input_dir"
fi

if $is_verbose ; then
    echo "set verbose mode"
fi

exit 0
