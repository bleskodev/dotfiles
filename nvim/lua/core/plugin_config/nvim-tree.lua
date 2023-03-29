local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("failed to require nvim-tree")
    return
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
})

-- keymaps
local keymap = vim.api.nvim_set_keymap

-- toggle file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc="Toggle file [e]xplorer" })
keymap("n", "<c-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true, desc="[n] Show file in file explorer" })

