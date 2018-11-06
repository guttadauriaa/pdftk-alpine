#!/bin/sh
# $0 is a script name
# $1, $2, $3, etc are passed arguments
# $1 is our command
echo "start of entrypoint.sh"
echo "VAR1 : $1"
echo "VAR2 : $2"
echo "VAR3 : $3"

FILE="$1"
OWNER_PW="$2"
USER_PW="$3"

# if $2 is passed as a parameter, use it
# otherwise choose a random one.
if [ -z "$2" ]
then
    OWNER_PW=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c10;echo;)
    echo "RANDOM KEY : $OWNER_PW"
else
    OWNER_PW="$2"
    echo "SUPPLIED KEY : $OWNER_PW"
fi

if [ -z "$3" ]
then
    echo "Protected against copy/paste."
    pdftk "$1" output "${1%.pdf}_protected.pdf" owner_pw $OWNER_PW
else
    echo "Crypting file, will need the key in order to read its content."
    echo "Uncrypt Key: $USER_PW"
    pdftk "$1" output "${1%.pdf}_protected.pdf" owner_pw $OWNER_PW user_pw $USER_PW
fi

