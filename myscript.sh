#!/bin/bash


function tree_structure() {
  local path="$1"
  local depth="${2:-0}"  
  local indent="  "    

 
  if [[ ! -d "$path" ]]; then
    return 1 
  fi


  for entry in $(find "$path" -maxdepth 1 -mindepth 1 ! -name . ! -name .. ! -path '*/\.*'); do

    # printf "%*s%s\n" "$((depth * indent))" "" "${entry##*/}"  

    # Create an indentation string that repeats for each depth level
    local indent_str=$(printf '%*s' $((depth * 2)) '')

    # Print the current entry, removing the path prefix to only display the basename
    printf "%s%s\n" "$indent_str" "${entry##*/}"

    
    if [[ -d "$entry" ]]; then
      tree_structure "$entry" $((depth + 1))
    fi
  done
}


directory="$1"


if [[ -z "$directory" ]]; then
  echo "Error: Please provide a directory path."
  exit 1
fi

tree_structure "$directory"

