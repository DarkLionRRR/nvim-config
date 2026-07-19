local M = {}

local MODULE_ROOT = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/module")
local MODULE_STUB = vim.fs.normalize(MODULE_ROOT .. "/make-module/module.stub")
local MODULE_CURSOR_ROW = 4
local MODULE_CURSOR_COL = 11

local function _make_path(module_name)
    return vim.fs.normalize(MODULE_ROOT .. "/" .. module_name .. "/module.lua")
end

local function _make_module(args)
    local module_path = _make_path(args.args)
    if vim.uv.fs_stat(module_path) then
        vim.notify("Module already exists.", vim.log.levels.ERROR)
        return
    end

    if vim.fn.mkdir(vim.fs.dirname(module_path)) ~= 1 then
        vim.notify("Can't create directory.", vim.log.levels.ERROR)
        return
    end

    if vim.fn.filereadable(MODULE_STUB) ~= 1 then
        vim.notify("Can't read stub-file.", vim.log.levels.ERROR)
        return
    end

    local content = vim.fn.readfile(MODULE_STUB, "b")
    if vim.fn.writefile(content, module_path, "b") == -1 then
        vim.notify("Can't create module-file.", vim.log.levels.ERROR)
        return
    end

    vim.cmd("edit" .. module_path)
    vim.api.nvim_win_set_cursor(vim.fn.win_getid(), { MODULE_CURSOR_ROW, MODULE_CURSOR_COL })
end

function M.load()
    vim.api.nvim_create_user_command("MakeModule", _make_module, { nargs = 1 })
end

return M
