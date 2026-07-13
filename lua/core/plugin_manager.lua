local M = {}

local PREFIX_MODULE = "plugin."
local PREFIX_URL = "https://github.com/"
local DIR = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/plugin")

local _is_loaded = false
local _plugins = {}

function M:pluck(field)
    assert(type(field) == "string", "field must be a string")

    local result = {}
    for i, val in ipairs(_plugins) do
        result[i] = val[field]
    end

    return result
end

local function _register_plugin(filename, filetype)
    if filetype ~= "file" or vim.fs.ext(filename) ~= "lua" then
        return
    end

    local plugin_cfg = require(PREFIX_MODULE .. string.sub(filename, 0, -5))
    if
        (type(plugin_cfg) ~= "table")
        or (type(plugin_cfg[1]) ~= "table" and type(plugin_cfg[1]) ~= "string")
    then
        return
    end
    if type(plugin_cfg[1]) == "string" then
        plugin_cfg = { plugin_cfg }
    end

    for i, item in ipairs(plugin_cfg) do
        _plugins[i] = {
            url = item.url or PREFIX_URL .. item[1],
            module = string.gsub(item[1], "%w+/", ""),
            opts = item.opts,
            config = item.config,
            map = item.map,
        }
    end
end

function M:preload()
    if _is_loaded then
        return
    end

    for filename, filetype in vim.fs.dir(DIR, {}) do
        _register_plugin(filename, filetype)
    end

    _is_loaded = true
end

function M:afterload()
    for _, plugin in ipairs(_plugins) do
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
end

return M
