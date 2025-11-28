#!/bin/bash
package=$1

if [[ -z "$package" || ! "$package" =~ .+/.+ ]]; then
	echo "Usage: $0 <module-type>/<package-name> <deps>"
	echo "Example:"
	echo "$0 yay/foo bar baz"
	echo "   Creates yay/foo.sh with '# deps: bar baz'"
	exit 1
fi

module_type=$(echo "$package" | cut -d'/' -f1)
package_name=$(echo "$package" | cut -d'/' -f2)
deps="${@:2}"

case $module_type in
"pacman")
	touch "./modules/pacman/$package_name.sh"
	if [[ -n "$deps" ]]; then
		echo "# deps: $deps" >>"./modules/pacman/$package_name.sh"
	fi
	echo "sudo pacman -S --noconfirm --needed $package_name" >>"./modules/pacman/$package_name.sh"
	chmod +x "./modules/pacman/$package_name.sh"
	;;
"yay")
	touch "./modules/yay/$package_name.sh"
	if [[ -n "$deps" ]]; then
		echo "# deps: $deps" >>"./modules/yay/$package_name.sh"
	fi
	echo "yay -S --noconfirm --needed $package_name" >>"./modules/yay/$package_name.sh"
	chmod +x "./modules/yay/$package_name.sh"
	;;
*)
	echo "Unsupported module type: $module_type"
	exit 1
	;;
esac

echo "$module_type/$package_name" >>"./packages.cfg"
