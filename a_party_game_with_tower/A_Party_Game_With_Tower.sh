#!/bin/sh
echo -ne '\033c\033]0;A_Party_Game_With_Tower\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/A_Party_Game_With_Tower.x86_64" "$@"
