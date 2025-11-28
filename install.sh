#!/usr/bin/env bash
set -euo pipefail

PACKAGES_CFG="./packages.cfg"
MODULES_DIR="./modules"

echo "🐦 | 💬 Hi, I am codevogel, and will guide you through the installation process."
echo "        Look for my bird icon 🐦 to follow my messages."
echo "        Speech bubbles 💬 indicate general information about the process."
echo "        Check marks ✅ indicate success."
echo "        Warnings ⚠️ and errors ❌ indicate problems."
echo "        You can sit back, though I may need your input a couple of times;"
echo "        For security, you may need to enter your sudo password."
echo ""

if [[ ! -f "$PACKAGES_CFG" ]]; then
  echo "🐦 | ❌ packages.cfg not found at: $(realpath "$PACKAGES_CFG")"
  exit 1
fi

if [[ ! -d "$MODULES_DIR" ]]; then
  echo "🐦 | ❌ modules directory not found at: $(realpath "$MODULES_DIR")"
  exit 1
fi

echo "🐦 | 💬 Starting primitive dependency check..."

#---- Load package list -------------------------------------------------------

# Read raw lines
mapfile -t raw_lines <"$PACKAGES_CFG"

# Filter out comments + blank lines
packages=()
for line in "${raw_lines[@]}"; do
  [[ -z "$line" ]] && continue
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  packages+=("$line")
done

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "🐦 | ⚠️ No packages found in packages.cfg"
  exit 0
fi

echo "🐦 | 📦 Packages to install (in order):"
printf '  - %s\n' "${packages[@]}"
echo

#---- Dependency check --------------------------------------------------------

declare -A listed_packages=() # set of installed package names: installed["yay"]=1

for entry in "${packages[@]}"; do
  # Parse module/pkg
  module="${entry%%/*}"
  pkg="${entry##*/}"
  script="$MODULES_DIR/$module/$pkg.sh"

  if [[ ! -f "$script" ]]; then
    echo "🐦 | ❌ ERROR: Module script missing: $script"
    exit 1
  fi

  # Read only the FIRST matching "# deps:" or "# deps"
  if dep_line=$(grep -m1 -E '^# deps?:' "$script" 2>/dev/null); then
    # Strip "# deps:" or "# deps"
    deps="${dep_line#\# deps:}"
    deps="${deps#\# deps}"

    for dep in $deps; do
      if [[ -z "${listed_packages[$dep]+x}" ]]; then
        echo "🐦 | ❌ Dependency error for package '$pkg' ($entry)"
        echo "     → Missing required dependency: '$dep'"
        echo "     → '$dep' must appear earlier in packages.cfg"
        exit 1
      fi
    done
  fi

  # Mark this package as installed
  listed_packages["$pkg"]=1
done

echo "🐦 | ✅ Primitive dependency check passed successfully!"
echo "     ℹ️ This does not guarantee that there won't be any missing dependencies."
echo "     It only checks for user-defined dependencies in the installation scripts."

# ---- Installation -------------------------------------------------------------

echo "🐦 | 🚀 Starting installation..."

for entry in "${packages[@]}"; do
  module="${entry%%/*}"
  pkg="${entry##*/}"
  script="$MODULES_DIR/$module/$pkg.sh"

  echo "🐦 | ➡️  Installing: $pkg (via $script)"

  # Each script is sourced so it can define functions or export variables
  # If it returns non-zero, the whole script stops (because of set -e)
  if ! source "$script"; then
    echo "🐦 | ❌ Installation failed for: $entry"
    exit 1
  fi

  echo "🐦 | ✅ Finished: $pkg"
  echo
done

echo "🐦 | All installation scripts have ran!"
