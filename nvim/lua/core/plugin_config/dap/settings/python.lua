local M = {}

M.setup = function()
	local dap_py_status_ok, dap_py = pcall(require, "dap-python")
	if not dap_py_status_ok then
		return
	end
    dap_py.setup("/usr/bin/python")
end

return M
