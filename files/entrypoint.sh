#!/bin/sh
# $0 is a script name
# $1, $2, $3, etc are passed arguments
# $1 is our command

FILE="${1}"
OWNER_PW="${2}"
USER_PW="${3}"

# if $2 is not passed as a parameter,
# choose a random one.
if [ -z "${OWNER_PW}" ]
then
    OWNER_PW=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c10;echo;)
fi

# if $USER_PW is not defined, forbid copy/paste
# otherwise crypt the file with the supplied key
if [ -z "$USER_PW" ]
then
    echo "Protected against copy/paste."
    pdftk "${FILE}" output "${FILE%.pdf}_protected.pdf" owner_pw "${OWNER_PW}"
    echo "New PDF file : ${FILE%.pdf}_protected.pdf"
else
    echo "Crypting file, will need the key in order to read its content."
    echo "Uncrypt Key: $USER_PW"
    pdftk "${FILE}" output "${FILE%.pdf}_protected.pdf" owner_pw "${OWNER_PW}" user_pw "${USER_PW}"
    echo "New PDF file : ${FILE%.pdf}_protected.pdf"
fi

