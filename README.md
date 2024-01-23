<div align="center">
  <h1 align="center">🚧 Still WIP 🚧</h1>
	<a href="https://github.com/thefirstminute/nvim/#features">Features</a>
  <span> | </span>
  <a href="https://github.com/thefirstminute/nvim/#requirements">Requirements</a>
  <span> | </span>
  <a href="https://github.com/thefirstminute/nvim/#installation">Installation</a>
  <span> | </span>
  <a href="https://github.com/thefirstminute/nvim/#thanks">Thanks</a>
  <span> </span>
</div>

# nvim
NeoVim configs (in Lua)

# Features
* WhichKey to help remember commands
* 'Normal' type commands from insert mode with leader ;
* 'QuickTxt' from insert with leader Q

# Requirements
* Needs at least Neovim 0.7


# Installation
_Before You Begin You Probably Need To (Re)move Local Files, If You've Already Been Running Neovim_
```sh
sudo rm -r .local/share/nvim
```
### 1. Install Neovim & Use (AppImage):
```sh
mkdir -p ~/Applications && cd ~/Applications
```
```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
```
```sh
chmod u+x nvim.appimage
```
```sh
CUSTOM_NVIM_PATH=~/Applications/nvim.appimage
# Set the above with the correct path, then run the rest of the commands:
set -u
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110
```

### 2. Clone the nvims:
```sh
mkdir -p ~/.config/nvim && cd ~/.config/nvim
```
_Make Sure You Don't Have Stuff In This Directory Before You Clone!!_
```sh
git clone https://github.com/thefirstminute/nvim.git
```
### 3. Install Packages & Language Support:

#### Open Neovim...
```sh
nvim init.lua
```


# Thanks
* [LunarVim](https://github.com/ChristianChiarulli/LunarVim) - after looking at Neovim's implementation of Lua several times, this finally pushed me over the edge
* [TJ](https://github.com/tjdevries) for [telescope](https://github.com/nvim-telescope) in particular, and work on Neovim... and everything else; I'm in awe
* [The Primeagen](https://github.com/ThePrimeagen) - Coding entertainment at it's finest
* [hrsh7th](https://github.com/hrsh7th) - all the completiony goodness!  wow, seriously
* [treesitter](https://github.com/nvim-treesitter) - one of the main reasons I made the leap

And, of course, everyone making [NeoVim](https://github.com/neovim/neovim) great!!
