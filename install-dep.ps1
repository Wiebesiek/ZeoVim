# Scoop bootstrap
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex

scoop bucket add main
scoop bucket add versions

# Install neovim
scoop install neovim

# Install ripgrep
scoop install main/ripgrep

# Install fd
scoop install main/fd

# Install zig
scoop install zig

# Need node?
# https://nodejs.org/en/download
# Install yarn
npm install --global yarn

# Installs python 3.11 -- see what version you want here: https://scoop.sh/#/apps?q=python
scoop install versions/python311

# Install fzf
scoop install main/fzf
