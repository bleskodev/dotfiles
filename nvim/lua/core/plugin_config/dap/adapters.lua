local adapters = {
	"python",
}

local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
	return
end

for _, adapter_name in pairs(adapters) do
	local require_ok, adapter = pcall(require, "core.plugin_config.dap.settings." .. adapter_name)
	if require_ok then
		adapter.setup()
	end
end

local signs = {
	{ name = "DapBreakpoint", text = "", color = "DiagnosticSignError" },
	{ name = "DapBreakpointCondition", text = "", color = "DiagnosticSignError" },
	{ name = "DapStopped", text = "", color = "DiagnosticSignInfo" },
	{ name = "DapBreakpointRejected", text = "", color = "DiagnosticSignError" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.color, text = sign.text, numhl = "" })
end
