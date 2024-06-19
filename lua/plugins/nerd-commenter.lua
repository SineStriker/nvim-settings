return {
    {
        'preservim/nerdcommenter',
        config = function()
            vim.g.NERDSpaceDelims = 1

            local keyset = vim.keymap.set
            -- 设置 Ctrl+/ 转换单行或选中行注释状态
            keyset('n', '<c-/>', '<Plug>NERDCommenterToggle', { noremap = false, silent = true })
            keyset('v', '<c-/>', '<Plug>NERDCommenterToggle', { noremap = false, silent = true })
            keyset('i', '<c-/>', '<Esc><Plug>NERDCommenterTogglei', { noremap = false, silent = true })
        end
    }
}
