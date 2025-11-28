#deps: curl
curl -LO https://github.com/sigoden/aichat/releases/download/v0.30.0/aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz
tar -xzf aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz
sudo mv aichat /usr/bin/
chmod +x /usr/bin/aichat
rm aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz
