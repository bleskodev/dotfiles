local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("failed to require nvim-tree")
    return
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- key bindings
local function nvt_on_attach(bufnr)
    local api = require "nvim-tree.api"

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, { desc = "nvim-tree: Up", buffer = bufnr, noremap = true, silent = true, nowait = true })
end

nvim_tree.setup({
    sort_by = "case_sensitive",
    on_attach = nvt_on_attach,
    view = {
        width = 30
    },
})

-- keymaps
local keymap = vim.api.nvim_set_keymap

-- toggle file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc="Toggle file [e]xplorer" })
keymap("n", "<c-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true, desc="[n] Show file in file explorer" })

