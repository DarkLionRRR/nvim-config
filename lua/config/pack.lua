local PLUGIN_ROOT = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/plugin")
local PLUGIN_PREFIX = "plugin."
local URL_PREFIX = "https://github.com/"

local function scan_plugins(filename, filetype)
    if filetype ~= "file" or vim.fs.ext(filename) ~= "lua" then
        return {}
    end

    local ok, plugin = pcall(require, PLUGIN_PREFIX .. string.sub(filename, 0, -5))
    if ok == false then
        vim.notify("Can't require plugin-file: " .. plugin, vim.log.levels.ERROR)
        return {}
    end

    if (type(plugin) ~= "table") or (type(plugin[1]) ~= "table" and type(plugin[1]) ~= "string") then
        vim.notify("Invalid plugin data in " .. filename, vim.log.levels.ERROR)
        return {}
    end

    if type(plugin[1]) == "string" then
        plugin = { plugin }
    end

    local result = {}
    for i, item in ipairs(plugin) do
        result[i] = {
            url = item.url or URL_PREFIX .. item[1],
            module = item.name or item[1]:match("/(.+)$"):gsub("%.nvim$", ""),
            opts = item.opts,
            config = item.config,
            map = item.map,
            version = item.version,
        }
    end

    return result
end

local function enable_plugin(plugin)
    if type(plugin.config) == "function" then
        plugin.config()
        return
    end

    local ok, module = pcall(require, plugin.module)
    if ok == false then
        return
    end

    if type(module.setup) == "function" and type(plugin.opts) == "table" then
        module.setup(plugin.opts)
    elseif type(module.setup) == "function" then
        module.setup()
    end
end

local scanned_plugins = {}
for filename, filetype in vim.fs.dir(PLUGIN_ROOT, {}) do
    for _, plugin in ipairs(scan_plugins(filename, filetype)) do
        table.insert(scanned_plugins, plugin)
    end
end

vim.pack.add(vim.tbl_map(function(plugin)
    return { src = plugin.url, version = plugin.version }
end, scanned_plugins))

for _, plugin in ipairs(scanned_plugins) do
    enable_plugin(plugin)
end

local disable_plugins = vim.iter(vim.pack.get())
    :filter(function(x)
        return not x.active
    end)
    :map(function(x)
        return x.spec.name
    end)
    :totable()
if not vim.tbl_isempty(disable_plugins) then
    vim.pack.del(disable_plugins)
end
