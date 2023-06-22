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
  - 🪛 Optional [static configuration](#-static-lsp-and-dap-configuration-for-projects) of dll, csproj and debug cwd for projects. Allowing a _smooooth_ debugging experience.

## 🔧 Setup

### 📦 Installation of Dependencies

See install [script](https://github.com/Wiebesiek/ZeoVim/blob/main/install-dep.ps1).

### ⚡️ Installation of Config

Clone config into `%USERPROFILE%\AppData\Local\nvim`

- `git clone git@github.com:Wiebesiek/ZeoVim.git`

#### Optional

Neorg uses an environment variable `NOTESDIR`. Set an environment variable take advantage of this.

## 🎨 Aesthetics

- 🔤 Font - [Comic shans](https://github.com/shannpersand/comic-shanns) nerd font in mono.
- 🟤 Colorscheme - [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
- 💻 Terminal - Windows terminal with gruvbox friendly background.

## 🪛 Static LSP and DAP Configuration For Projects

In `init.lua` there is protected call to `zeovim.secrets.path_finder`. Create a file and make a call to `utilities.path_finder.setup` with the necessary config.

Ex: `zeovim\secrets\path_finder.lua`

```lua
require('zeovim.utilities.path_finder').setup({
  projects = {
    {
      base_path = "C:/Foo",
      dotnet_proj_file = "C:/Foo/Foo.csproj",
      dotnet_dll_path = "C:/Foo/bin/Debug/net6.0/foo.dll",
      dotnet_debug_cwd = "C:/Foo" -- Useful for large, multi-project debugging
    }
  }
})
```

In `zeovim\config\dap.lua`, the `path_finder` is called to use these values if the current filepath that is being debugged starts with `C:\Foo`.

```lua
dap.adapters.coreclr = {
  type = 'executable',
  command = dotnet_ph.GetNetCoreDbgPath(),
  args = { '--interpreter=vscode' },
  options = {
    detached = false,
    cwd = dotnet_ph.GetDebugCwd(),
  }
}
```

## A Word On Versions

I use this config on a windows machine and use tools for dotnet development, namely Omnisharp and Csharpier. This tooling can be susceptible to bugs that may exist in the nightly versions of Neovim as there are fewer people with similar setups. Thankfully, gone are the days where seemingly every plugin requested that you be on a nightly build. For these reasons, the best dotnet experience will be on the latest stable release of Neovim.
