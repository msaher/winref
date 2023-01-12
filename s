#!/bin/bash

if [ -z "$1" ]; then
	explorer.exe .
	exit 0
fi

arg="$(wslpath -w "$*")"
cmd.exe /c start "Launching from BASH" "$arg"
