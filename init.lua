-- 基本设置
require("core.basic")

-- 快捷键
require("core.keymap")

-- 启用第一个插件管理器 vim-plug
require("core.plug")

-- 启用上一次的颜色主题
local theme = require('last-color').recall() or 'default'
vim.cmd.colorscheme(theme)