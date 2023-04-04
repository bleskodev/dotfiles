local adapters = {
    "python",
}

local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
    return
end

for _, adapter_name in pairs(adapters) do

    local require_ok, adapter = pcall(require, "core.plugin_config.dap.settings." .. adapter_name)
    if require_ok then
        adapter.setup()
    end
end
