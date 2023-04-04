local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    print "null_ls failed"
    return
end

local formatting = null_ls.builtins.formatting
--local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
    sources = {
        formatting.stylua,
        formatting.rustfmt,
        formatting.yapf,
    },
}
