local Plug = vim.fn['plug#']

-- 安装插件
vim.call('plug#begin')

Plug('folke/lazy.nvim')   -- lazy.nvim 插件管理器

vim.call('plug#end')

-- 检查一个插件是否存在（插件管理器，插件名称）
local function plugin_exists(plugin_framework, plugin_name, add_path)
    local plugin_path = vim.fn.stdpath("data") .. "/" .. plugin_framework .. "/" .. plugin_name
    if (vim.uv or vim.loop).fs_stat(plugin_path) then
        if (add_path or false) then
            vim.opt.rtp:prepend(plugin_path)
        end
        return true
    end
    return false
end

-- 尝试启动 lazy.nvim
if plugin_exists("plugged", "lazy.nvim", true) then
    require("lazy").setup("plugins")
    
    -- 尝试启用上一次的颜色主题
    if plugin_exists("lazy", "last-color.nvim") then
        local theme = require('last-color').recall() or 'default'
        vim.cmd.colorscheme(theme)
    end
end