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

-- 撤销/重做
-- local function safe_undo()
--     local utree = vim.fn.undotree()
--     if utree.seq_cur > 1 then
--         vim.cmd('undo')
--     end
--     print("Undo111")
-- end
  
-- local function safe_redo()
--     local utree = vim.fn.undotree()
--     if utree.seq_cur < utree.seq_last then
--         vim.cmd('redo')
--     end
--     print("Redo111")
-- end
  
-- vim.api.nvim_create_user_command('SafeUndo', safe_undo, {})
-- vim.api.nvim_create_user_command('SafeRedo', safe_redo, {})

-- keyset('i', '<a-z>', '<C-G>u<C-R>', { noremap = true, silent = true })
-- keyset('i', '<a-s-z>', '<C-G>U<C-R>', { noremap = true, silent = true })