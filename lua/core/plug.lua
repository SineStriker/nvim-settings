local Plug = vim.fn['plug#']

-- 安装插件
vim.call('plug#begin')

Plug('folke/lazy.nvim')   -- lazy.nvim 插件管理器 
-- Plug('neoclide/coc.nvim', { ['branch'] = 'release' }) -- coc.nvim 插件管理器

vim.call('plug#end')

-- 检查一个插件是否存在
local function plug_exists(plugin_name)
    local plugin_path = vim.fn.stdpath("data") .. "/plugged/" .. plugin_name
    if (vim.uv or vim.loop).fs_stat(plugin_path) then
        vim.opt.rtp:prepend(plugin_path)
        return true
    end
    return false
end

-- 尝试启动 lazy.nvim
if plug_exists("lazy.nvim") then
    require("lazy").setup("plugins")
end
