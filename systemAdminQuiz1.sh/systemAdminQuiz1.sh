#!/bin/bash

topdirectory=$1
identifier=$2

if [[ -z "$topdirectory" ]] && [[ -z "$identifier" ]]
then
    echo "You need to proved two arguments for this script to work."
    echo "Usage: make-go-dir <root directory name> <indentifier name>"
    exit 0
fi

echo "I am about to create a directory structure named $topdirectory"
echo "Do you want me to continue? [Yes/no]"
read usr_answer #| tr [:upper:] [:lower:]

if [ "$usr_answer" == "Yes" ]
then
    echo -e "\nCreate directory structure..."
    mkdir -p $topdirectory
    cd $topdirectory
    mkdir -p cmd/api migrations remote internals
    touch Makefile
    touch cmd/api/main.go
    go mod init "$topdirectory.$identifier"
    go mod tidy
    echo -e "// File: cmd/api/main.go\n\npackage main\nimport \"fmt\"\nfunc main() {\nfmt.Println(\"Hello world!\")\n}" >> cmd/api/main.go
else
    echo "Abort"
    exit 0
fi

echo -e "\nI have created a *main.go* file for you to test the directory structure."
echo "Type *go run ./cmd/api* at the root diretory($topdirectory) of your project to test your project."
echo "Thank You."
