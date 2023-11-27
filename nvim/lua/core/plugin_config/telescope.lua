local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},
			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["?"] = actions.which_key,
			},
		},
	},
	-- pickers = {
	-- Default configuration for builtin pickers goes here:
	-- picker_name = {
	--   picker_config_key = value,
	--   ...
	-- }
	-- Now the picker_config_key will be applied every time you call this
	-- builtin picker
	-- },
	--extensions = {
	-- Your extension configuration goes here:
	-- extension_name = {
	--   extension_config_key = value,
	-- }
	-- please take a look at the readme of the extension you want to configure
	-- },
})

telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")

-- keymaps
local keymap = vim.api.nvim_set_keymap

local function get_keymap_options(desc)
	return { noremap = true, silent = true, desc = desc }
end

keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", get_keymap_options("[F]ind [f]iles"))
keymap("n", "<leader>fg", "<cmd>Telescope live_grep_args<CR>", get_keymap_options("[F]ind by [G]rep"))
keymap("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", get_keymap_options("[F]ind [W]ord under cursor"))
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", get_keymap_options("[F]ind in [H]elp"))
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", get_keymap_options("[F]ind in [O]ld files"))
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", get_keymap_options("[F]ind in [D]iagnostic"))
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", get_keymap_options("[F]ind in [K]eymaps"))
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", get_keymap_options("[F]ind in [B]uffers"))
keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", get_keymap_options("[F]ind [R]eferences"))
keymap(
	"n",
	"<leader>fm",
	"<cmd>Telescope lsp_document_symbols symbols=function<CR>",
	get_keymap_options("[F]ind [M]ethod")
)
