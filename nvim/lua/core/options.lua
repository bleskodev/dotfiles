-- see: help options
local options = {
    expandtab = true,           -- convert tabs to spaces
    tabstop = 4,                -- insert X spaces for a tab
    shiftwidth = 4,             -- the number of spaces inserted for each indentation
    smartindent = true,         -- do smartindenting when starting a new line
    number = true,              -- show line numbers
    splitbelow = true,          -- horizontal splits go below current window
    splitright = true,          -- vertical splits go to the right of the current window
    cmdheight = 2,              -- more space in the cmd line for displaying messages
    ignorecase = true,          -- ignore case in search patterns
    smartcase = true,           -- overrides ignorecase if search pattern contains uppercase letters
    fileencoding = "utf-8",     -- the encoding written to a file
    scrolloff = 3,              -- display minimum 3 lines around cursor
    cursorline = true,          -- highlight the current line
    clipboard = "unnamedplus",  -- access to system clipboard
    updatetime = 300,           -- faster completion (4000ms is default)
    timeoutlen = 300,           -- time to wait for a mapped sequence to complete
    timeout = true,             -- goes with timeoutlen
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
