#!/bin/bash

# Function to check installation order
check_install_order() {
  local files=("$@")
  local packages=()

  # Extract package names
  for file in "${files[@]}"; do
    package_name=$(basename "$file" | sed 's/install-//;s/\.sh//')

    # Extract dependencies from the file
    dependencies=$(grep -iE "#*.deps*.:" $file | sed 's/#*.deps*.//I' | tr -d ' ')
    # for each dependency by comma
    for dependency in $(echo "$dependencies" | tr ',' '\n'); do
      # Check if the dependency is in the list of packages
      if ! echo "${packages[@]}" | grep -q "$dependency"; then
        echo "❌ INVALID INSTALLATION ORDER (at $file):"
        echo "The installer for '$package_name' lists '$dependency' as a dependency, but '$dependency' is not yet present in the list of packages."
        return 1
      fi
    done

    packages+=("$package_name")
  done

  echo "🗨️ All packages are in the correct order."
  return 0
}

get_files_from_config() {
  local install_dir="$1"
  local conf_file="$install_dir/active.conf"

  # Check if the configuration file exists
  if [ ! -f "$conf_file" ]; then
    echo "❌ Configuration file not found: $conf_file"
    exit 1
  fi

  # Create array of lines from config
  lines=()

  # Read the configuration file line by line
  while IFS= read -r line; do
    # Ignore lines starting with '#' and empty lines
    if [[ $line != \#* ]] && [ -n "$line" ]; then
      # If path starts with './', replace it with the path to the install directory
      if [[ $line == ./* ]]; then
        line="$install_dir/${line:2}"
      fi
      # add line to array
      lines+=($(echo $line | sed 's/\.sh.*/.sh/'))
    fi
  done <"$conf_file"
  echo ${lines[@]}
}
