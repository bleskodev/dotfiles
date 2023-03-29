local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require "core.plugin_config.lsp.servers"
require ("core.plugin_config.lsp.handlers").setup()
require "core.plugin_config.lsp.null-ls"
