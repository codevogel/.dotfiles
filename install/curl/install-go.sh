#!/bin/bash
# Download the latest version URL
latest=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
latest_url="https://golang.org/dl/$latest.linux-amd64.tar.gz"

# Remove existing Go installation
rm -rf /usr/local/go

# Download the latest Go tarball using curl
curl -o go.tar.gz -L "$latest_url"

# Extract the downloaded tarball to /usr/local
tar -C /usr/local -xzf go.tar.gz

# Remove the downloaded tarball
rm go.tar.gz
