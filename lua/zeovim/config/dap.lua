local status, dap = pcall(require, 'dap')
if (not status) then
	print("dap not loaded")
	return
end

local dap_status, dapui = pcall(require, 'dapui')
if (not dap_status) then
	print("dapui not loaded")
	return
end

local ph_status, dotnet_ph = pcall(require, 'utilities.path_helpers')
if (not ph_status) then
	print("path_helpers not loaded")
	return
end

dap.adapters.coreclr = {
	type = 'executable',
	command = dotnet_ph.GetNetCoreDbgPath(),
	-- command = netcoredbg_path,
	args = { '--interpreter=vscode' },
	options = {
		detached = false -- Will put the output in the REPL. #CloseEnough
	}
}

-- Test runner looks at this table
dap.adapters.netcoredbg = vim.deepcopy(dap.adapters.coreclr)

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = dotnet_ph.GetDllPath,
		-- stopAtentry = true,
		console = "integratedTerminal"
	},
}

local status_ui, dap_ui = pcall(require, 'dapui')
if (not status_ui) then
	print("dapui not loaded")
	return
end

dap_ui.setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = ""
		}
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" }
		}
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = ""
	},
	layouts = { {
		elements = { {
			id = "console",
			size = 0.2
		}, {
			id = "breakpoints",
			size = 0.2
		}, {
			id = "stacks",
			size = 0.2
		}, {
			id = "repl",
			size = 0.2
		}, {
			id = "watches",
			size = 0.2
		} },
		position = "left",
		size = 50
	}, {
		elements = {  {
			id = "scopes",
			size = 1
		} },
		position = "bottom",
		size = 10
	} },
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t"
	},
	render = {
		indent = 1,
		max_value_lines = 100
	}
})
------------
-- Dap UI --
------------

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

-- SET DEBUG --
dap.set_log_level('TRACE') -- can be found at appdata\local\temp\nvim\dap.log



------------
-- PYTHON --
------------
dap.adapters.python = function(cb, config_py)
	if config_py.request == 'attach' then
		---@diagnostic disable-next-line: undefined-field
		local port = (config_py.connect or config_py).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config_py.connect or config_py).host or '127.0.0.1'
		cb({
			type = 'server',
			port = assert(port, '`connect.port` is required for a python `attach` configuration'),
			host = host,
			options = {
				source_filetype = 'python',
			},
		})
	else
		cb({
			type = 'executable',
			command = vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/Scripts/python'),
			args = { '-m', 'debugpy.adapter' },
			options = {
				source_filetype = 'python',
			},
		})
	end
end
dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch',
		name = "Launch file",
		console = "integratedTerminal",
		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			-- local cwd = vim.fn.getcwd()
			-- if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
			--   return cwd .. '/venv/bin/python'
			-- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
			--   return cwd .. '/.venv/bin/python'
			-- else
			-- return 'C:\\Windows\\py.exe'
			return 'C:\\Windows\\py.exe'
			--end
		end,
	},
}
