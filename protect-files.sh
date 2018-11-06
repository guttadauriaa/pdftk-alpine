#!/bin/bash

if (( $# < 1 )); then
    printf "\nYou must pass at least a path to a pdf file :\n"
    printf "  protect-files.sh ./my-file.pdf\n\n"
    echo "In order to forbid copy/paste with a custom key :"
    printf "  protect-files.sh ./my-file.pdf forbidcopykey\n\n"
    echo "And to make the file unreadable without the key :"
    printf "  protect-files.sh ./my-file.pdf forbidcopykey cryptkey\n\n"
fi

echo "in protect-files.sh"
echo "ARG 1 : $1"
echo "ARG 2 : $2"
echo "ARG 3 : $3"
echo ""

case "$#" in
    "1")
        echo "in case args equals 1"
        docker run -it --rm --name=test -v $(pwd):/files pdftktest "$1"
        ;;
    "2")
        echo "in case args equals 2"
        docker run -it --rm --name=test -v $(pwd):/files pdftktest "$1" "$2"
        ;;
    "3")
        echo "in case args equals 3"
        docker run -it --rm --name=test -v $(pwd):/files pdftktest "$1" "$2" "$3"
        ;;
esac
