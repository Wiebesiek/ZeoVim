# ZeoVim
![image](https://github.com/Wiebesiek/ZeoVim/assets/44254336/cdbacf94-fd9f-4554-abec-69043b1696d8)

My neovim config. Oriented around dotnet and typescript development on a windows device.

## ✨ Features
- 🚀 [Lazy](https://github.com/folke/lazy.nvim) package manager for freaky fast start.
- 🛠️ LSP - including omnisharp for dotnet development.
- 🔬 DAP - including netcoredbg for dotnet debugging.
- 🧪 [Neotest](https://github.com/nvim-neotest/neotest) for running unit tests.
- 🧱 [Mason](https://github.com/williamboman/mason.nvim) to allow auto install of dap, lsp, and formatters such as csharpier.
- 🛩️ [Copilot](https://github.com/github/copilot.vim) as your AI assistant.
- 👨‍🔬 Pathhelper utilites to wire up omnisharp and netcoredbg
## Setup

### **Installation of Dependencies**

- [Chocolatey](https://community.chocolatey.org/)
  - This is optional. Though, it is nice for installing other apps.
  - TODO: create a choco script to install most of the other apps.
- [Scoop](https://scoop.sh/)
  - Zig does not have a chocolatey package. So, scoop is used to install it.
- `scoop install zig`
  - Treesitter highlighting needs a clang compiler. On windows, there can be some annoyances with this. See their Windows support [help](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support). I have found the easiest way to do this, is to install `zig` via [scoop](https://github.com/ziglang/zig/wiki/Install-Zig-from-a-Package-Manager).
- `choco install ripgrep`
  - Needed for telescope grep search. Useful tool outside of neovim.
- `choco install git`
- `choco install yarn`
- `choco install python`
- `choco install neovim --pre`
  - This will install neovim beta. As of now, most plugins function better with this version.
- `choco install nodejs.install`
- `choco install fd`
  - Needed for telescope file search. Great command line tool for searching for files.

### **Installation of Config**

Clone config into `%USERPROFILE%\AppData\Local\nvim`

- `git clone git@github.com:Wiebesiek/ZeoVim.git`
