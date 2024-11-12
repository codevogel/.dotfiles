#!/bin/bash
curl -s https://ohmyposh.dev/install.sh | sudo bash -s
mkdir -p ~/.poshthemes
curl -s https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/patriksvensson.omp.json --output ~/.poshthemes/patriksvensson.omp.json
