#!/bin/sh
echo -ne '\033c\033]0;Left 4 Bread\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Left4Bread.x86_64" "$@"
