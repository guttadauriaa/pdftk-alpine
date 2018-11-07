#!/bin/bash

if (( $# < 1 )); then
    printf "\nYou must pass at least a path to a pdf file :\n"
    printf "  protect-files.sh ./my-file.pdf\n\n"
    echo "In order to forbid copy/paste with a custom key :"
    printf "  protect-files.sh ./my-file.pdf forbidcopykey\n\n"
    echo "And to make the file unreadable without the key :"
    printf "  protect-files.sh ./my-file.pdf forbidcopykey cryptkey\n\n"
fi

case "$#" in
    "1")
        echo "Forbid copy/paste"
        docker run -it --rm --name=pdftk-alpine -v $(pwd):/files pdftk-alpine "${1}"
        ;;
    "2")
        echo "Forbid copy/paste with custom key : ${2}"
        docker run -it --rm --name=pdftk-alpine -v $(pwd):/files pdftk-alpine "${1}" "${2}"
        ;;
    "3")
        echo "Crypting file with the following key : ${3}"
        docker run -it --rm --name=pdftk-alpine -v $(pwd):/files pdftk-alpine "${1}" "${2}" "${3}"
        ;;
esac
