#!/usr/bin/env bash

if ! command -v code > /dev/null 2>&1
then
    echo "VS Code not found. Please install VS Code first"
    exit 1
fi

package_name="python3-nautilus"
found_package=$(apt-cache search --names-only $package_name)
if [ -z "$found_package" ]
then
    package_name="python-nautilus"
fi

installed=$(apt list --installed $package_name -qq 2> /dev/null)
if [ -z "$installed" ]
then
    sudo apt-get install -y $package_name
else
    echo "$package_name is already installed."
fi

echo "Removing previous version (if found)..."

mkdir -p ~/.local/share/nautilus-python/extensions

rm -f ~/.local/share/nautilus-python/extensions/code-nautilus.py

echo "Downloading newest version..."
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/code-nautilus.py https://raw.githubusercontent.com/heinrichschiller/vs-code-nautilus-extension/main/code-nautilus.py

echo "Restarting nautilus..."
nautilus -q

echo "Installation Complete"
