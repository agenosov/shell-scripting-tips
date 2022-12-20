#!/bin/bash

# This script demonstrates:
# 1. one of the consequences of not wrapping variables into quotes
#
#    - try to pass an undefined variable without quotes as an argument to the 'md5sum' command and see what would happen.
#
# 2. pitfall of using the 'declare -r <some_var>' inside a sub-function
#
#    - it turnes out that in such case the variable would be local and attempt to use it outside would lead to an empty value.

properly_defined_path=""

main()
{
    define_path_improperly
    define_path_properly

    # Here we try to access to a variable defined in sub-function via 'declare -r'...
    # We wouldn't get any value
    echo $(md5sum "$improperly_defined_path")
    echo

    # Now we would succeeded
    echo $(md5sum "$properly_defined_path")
    echo

    # And here is a surprise: don't wrap a path into quotes...
    # A call to md5sum leads to an attempt to read from stdin, not an empty path
    echo "Now we would hung up. Wait sometime and interrupt the script - it can't exit..."
    echo
    echo $(md5sum $improperly_defined_path)
}

define_path_improperly()
{
    declare -r improperly_defined_path=`mktemp --dry-run`
}

define_path_properly()
{
    properly_defined_path=`mktemp --dry-run`
}

main "$@"
