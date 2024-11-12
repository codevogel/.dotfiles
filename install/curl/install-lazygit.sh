#!/bin/bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit


# Check if lazygit is installed by running lazygit --version and checking if the output contains "not found"
if ! lazygit --version > /dev/null 2>&1; then
  echo "❌ lazygit installation failed"
  exit 1
fi

