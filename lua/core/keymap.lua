local keyset = vim.keymap.set   -- 快捷键
local opt = { noremap = true, silent = true }

-- https://unix.stackexchange.com/questions/11402/why-does-esc-move-the-cursor-back-in-vim
-- 防止按 Esc 回到普通模式后光标左移
vim.cmd [[ au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1]) ]]

-- 设置 Tab 与 Shift+Tab 为选中行首部增加或删除制表符
keyset('v', '<Tab>', '>gv', opt)
keyset('v', '<S-Tab>', '<gv', opt)

-- Ctrl+S 保存
keyset('i', '<c-s>', '<Esc>:w<CR>i', opt)