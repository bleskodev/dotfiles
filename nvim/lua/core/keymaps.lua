local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

-- function name alias
local keymap = vim.api.nvim_set_keymap

local function get_keymap_opts_with_description(desc)
    local result = opts
    result['desc'] = desc
    return result
end

-- leader key
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c"

-- Normal --
-- Better window navigation (handled with tmux-navigator)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- insert blank line without entering insert mode
keymap("n", "<leader>o", "o<ESC>", opts)
keymap("n", "<leader>O", "O<ESC>", opts)

keymap("n", "gt", "<C-]>", get_keymap_opts_with_description("GoTo [t]ag"))

-- Insert --
-- more convenient <esc> in insert mode
keymap("i", "jk", "<ESC>", opts)


-- Visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "<A-j>", "xp'[V']", opts)
keymap("v", "<A-k>", "xkkp'[V']", opts)

-- keep last yank on paste
keymap("v", "p", '"_dP', opts)

