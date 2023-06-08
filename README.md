# ZeoVim
![image](https://github.com/Wiebesiek/ZeoVim/assets/44254336/8f2a5d73-b5d9-4d79-a8df-ddcdbbe1bd62)

My neovim config. Oriented around dotnet and typescript development on a windows device.

## ✨ Features
- 🚀 [Lazy](https://github.com/folke/lazy.nvim) package manager for freaky fast start.
- 🛠️ LSP - including omnisharp for dotnet development.
- 🔬 DAP - including netcoredbg for dotnet debugging.
- 🧪 [Neotest](https://github.com/nvim-neotest/neotest) for running unit tests.
- 🧱 [Mason](https://github.com/williamboman/mason.nvim) to allow auto install of dap, lsp, and formatters such as csharpier.
- 🛩️ [Copilot](https://github.com/github/copilot.vim) for an AI assistant.
- 👨‍🔬 Path helper utilites to wire up omnisharp and netcoredbg.
## 🔧 Setup

### 📦 Installation of Dependencies
See install [script](https://github.com/Wiebesiek/ZeoVim/blob/main/install-dep.ps1).
### ⚡️ Installation of Config

Clone config into `%USERPROFILE%\AppData\Local\nvim`

- `git clone git@github.com:Wiebesiek/ZeoVim.git`

## 🎨 Aesthetics
- 🔤 Font - [Comic shans](https://github.com/shannpersand/comic-shanns) nerd font in mono.
- 🟤 Colorscheme - [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
- 💻 Terminal - Windows terminal with gruvbox friendly background.

## A Word On Versions
I use this config on a windows machine and use tools for dotnet development, namely Omnisharp and Csharpier. This tooling can be susceptible to bugs that may exist in the nightly versions of Neovim as there are fewer people with similar setups. Thankfully, gone are the days where seemingly every plugin requested that you be on a nightly build. For these reasons, the best dotnet experience will be on the latest stable release of Neovim.

