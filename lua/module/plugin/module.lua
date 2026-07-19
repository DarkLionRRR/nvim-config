local M = {}

local PLUGIN_ROOT = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/plugin")
local PLUGIN_PREFIX = "plugin."
local URL_PREFIX = "https://github.com/"

local function _get_plugins(filename, filetype)
    if filetype ~= "file" or vim.fs.ext(filename) ~= "lua" then
        return {}
    end

    local ok, plugin = pcall(require, PLUGIN_PREFIX .. string.sub(filename, 0, -5))
    if ok == false then
        vim.notify("Can't require plugin-file: " .. plugin, vim.log.levels.ERROR)
        return {}
    end

    if
        (type(plugin) ~= "table")
        or (type(plugin[1]) ~= "table" and type(plugin[1]) ~= "string")
    then
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
            module = string.gsub(item[1], "%w+/", ""),
            opts = item.opts,
            config = item.config,
            map = item.map,
        }
    end

    return result
end

local function _enable_plugin(plugin)
    if type(plugin.config) == "function" then
        plugin.config()
        return
    end

    if type(plugin.opts) == "table" then
        local module = require(plugin.module)
        if type(module.setup) == "function" then
            module.setup(plugin.opts)
        end
    end
end

function M.load()
    if package.loaded["module.plugin"] ~= nil then
        return
    end

    local plugins = {}
    for filename, filetype in vim.fs.dir(PLUGIN_ROOT, {}) do
        table.insert(plugins, _get_plugins(filename, filetype))
    end
    plugins = vim.fn.flatten(plugins, 1)

    vim.pack.add(vim.tbl_map(function(plugin)
        return plugin.url
    end, plugins))

    for _, plugin in ipairs(plugins) do
        _enable_plugin(plugin)
    end

    local disable_plugins = vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x) return x.spec.name end)
        :totable()
    if not vim.tbl_isempty(disable_plugins) then
        vim.pack.del(disable_plugins)
    end
end

return M
