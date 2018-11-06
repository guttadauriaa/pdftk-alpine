#!/bin/sh
# $0 is a script name
# $1, $2, $3, etc are passed arguments
# $1 is our command

FILE="$1"
OWNER_PW="$2"
USER_PW="$3"

# if $2 is passed as a parameter, use it
# otherwise choose a random one.
if [ -z "$2" ]
then
    OWNER_PW=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c10;echo;)
else
    OWNER_PW="$2"
fi

if [ -z "$3" ]
then
    echo "Protected against copy/paste."
    pdftk "$1" output "${1%.pdf}_protected.pdf" owner_pw $OWNER_PW
    echo "New PDF file : ${1%.pdf}_protected.pdf"
else
    echo "Crypting file, will need the key in order to read its content."
    echo "Uncrypt Key: $USER_PW"
    pdftk "$1" output "${1%.pdf}_protected.pdf" owner_pw $OWNER_PW user_pw $USER_PW
    echo "New PDF file : ${1%.pdf}_protected.pdf"
fi

