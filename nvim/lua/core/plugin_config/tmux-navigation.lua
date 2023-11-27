local status_ok, tmux_nav = pcall(require, "nvim-tmux-navigation")
if not status_ok then
    print("failed to require nvim-tmux-navigation")
    return
end

tmux_nav.setup({})

-- keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", tmux_nav.NvimTmuxNavigateLeft, opts)
vim.keymap.set("n", "<C-j>", tmux_nav.NvimTmuxNavigateDown, opts)
vim.keymap.set("n", "<C-k>", tmux_nav.NvimTmuxNavigateUp, opts)
vim.keymap.set("n", "<C-l>", tmux_nav.NvimTmuxNavigateRight, opts)
