local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dapui_widgets_status_ok, dapui_widgets = pcall(require, "dap.ui.widgets")
if not dapui_widgets_status_ok then
	return
end

vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
vim.keymap.set("n", "<Leader>dt", dap.terminate, { desc = "[D]ebug [T]erminate" })
vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "[D]ebug Step [O]ver" })
vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "[D]ebug Step [I]nto" })
vim.keymap.set("n", "<Leader>de", dap.step_out, { desc = "[D]ebug St[e]p Out" })
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "[D]ebug Toggle [b]reakpoint" })
vim.keymap.set("n", "<Leader>dB", function()
	dap.set_breakpoint(vim.fn.input(vim.fn.input("Breakpoint condition: ")))
end, { desc = "[D]ebug Conditional [B]reakpoint" })
vim.keymap.set("n", "<Leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "[D]ebug Set [L]og point" })
vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "[D]ebug Open [R]EPL/Debug console" })
vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "[D]ebug Run [L]ast" })
vim.keymap.set({ "n", "v" }, "<Leader>dh", dapui_widgets.hover, { desc = "[D]ebug [H]over" })
vim.keymap.set({ "n", "v" }, "<Leader>dp", dapui_widgets.preview, { desc = "[D]ebug [P]review" })
vim.keymap.set("n", "<Leader>df", function()
	dapui_widgets.centered_float(dapui_widgets.frames)
end, { desc = "[D]ebug [F]rames" })
vim.keymap.set("n", "<Leader>ds", function()
	dapui_widgets.centered_float(dapui_widgets.scopes)
end, { desc = "[D]ebug [S]copes" })
