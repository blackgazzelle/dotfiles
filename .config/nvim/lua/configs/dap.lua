local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	print("nvim-dap not installed!")
	return
end

local dapui = require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
dapui.setup({})

--require('dap').set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog

dap.configurations = {
	go = {
		{
			type = "go", -- Which adapter to use
			name = "Debug", -- Human readable name
			request = "launch", -- Whether to "launch" or "attach" to program
			program = "${file}", -- The buffer you are focused on when running nvim-dap
		},
	},
	python = {
		{
			type = "python", -- Which adapter to use
			name = "Debug", -- Human readable name
			request = "launch", -- Whether to "launch" or "attach" to program
			program = "${file}", -- The buffer you are focused on when running nvim-dap
		},
	},
}
