-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"      -- Have packer manage itself
    use "nvim-tree/nvim-tree.lua"     -- file explorer
    use "nvim-tree/nvim-web-devicons" -- file icons
    use "windwp/nvim-autopairs"       -- closes parenthesis automatically
    use "nvim-lualine/lualine.nvim"   -- status line
    use "numToStr/Comment.nvim"       -- comment plugin
    use "akinsho/bufferline.nvim"     -- tab-like buffer display at the top
    use "folke/which-key.nvim"        -- show popup with keybindings

    -- Colorscheme
    use "ellisonleao/gruvbox.nvim"

    -- snippets
    use "L3MON4D3/LuaSnip"         -- snippet engine
    -- cmp
    use "hrsh7th/nvim-cmp"         -- completion plugin
    use "hrsh7th/cmp-buffer"       -- buffer source for completion
    use "hrsh7th/cmp-path"         -- path source for completion
    use "hrsh7th/cmp-cmdline"      -- cmdline source for completion
    use "hrsh7th/cmp-nvim-lsp"     -- lsp source for completion
    use "hrsh7th/cmp-nvim-lua"     -- nvim-lua source for completion
    use "saadparwaiz1/cmp_luasnip" -- snippet source for completion

    -- lsp
    use "neovim/nvim-lspconfig" -- basic configuration for integrated LSP
    use {
        -- for formatters and linters
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }

    -- telescope and dependencies
    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }
    use "nvim-telescope/telescope-file-browser.nvim"

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    -- debugging
    use "mfussenegger/nvim-dap"
    use "mfussenegger/nvim-dap-python"
    use "rcarriga/nvim-dap-ui"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
