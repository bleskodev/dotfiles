local colorscheme = "gruvbox"

-- setup for specific colorscheme
if colorscheme == "gruvbox" then
    local gruvbox_status_ok, gruvbox = pcall(require, "gruvbox")
    if not gruvbox_status_ok then
        return
    end
    gruvbox.setup({
        overrides = {
            LspReferenceText = { bg = "#3b4261" },
            LspReferenceRead = { bg = "#3b4261" },
            LspReferenceWrite = { bg = "#3b4261" },
        },
    })
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.o.termguicolors = true  -- 24-bit color support
