local MODULE_ROOT = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/module")
local MODULE_PREFIX = "module."

local function _require_module(module_name, filetype)
    if filetype ~= "directory" then
        return
    end

    local ok, result = pcall(require, MODULE_PREFIX .. module_name .. ".module")
    if ok == false then
        vim.notify("Don't include module: " .. result, vim.log.levels.ERROR)
        return
    end

    if type(result.load) ~= "function" then
        vim.notify("Module must contain load() function.", vim.log.levels.ERROR)
        return
    end

    result.load()
end

for filename, filetype in vim.fs.dir(MODULE_ROOT, {}) do
    _require_module(filename, filetype)
end
