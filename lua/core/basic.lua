local o = vim.o                 -- 全局选项
local bo = vim.bo               -- 缓冲区选项
local wo = vim.wo               -- 窗口选项
local g = vim.g                 -- 全局选项 2

-- 全局选项
o.encoding = "utf-8"
o.fileencoding = "utf-8"

o.number = true                 -- 显示行号
o.tabstop = 4                   -- 制表符宽度
o.shiftwidth = 4                -- 缩进宽度
o.expandtab = true              -- 空格代替制表符
o.autoindent = true             -- 自动缩进

o.wrap = false                  -- 禁止自动换行
o.cursorline = true             -- 启用光标

o.mouse = "a"                   -- 启用鼠标
o.clipboard = "unnamedplus"     -- 启用系统剪贴板

o.splitright = true             -- 向右拆分窗口
o.splitbelow = true             -- 向下拆分窗口

o.termguicolors = true          -- 真彩色支持

g.mapleader = ' '               -- 设置主键为空格
