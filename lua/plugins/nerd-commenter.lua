return {
    {
        'preservim/nerdcommenter',
        config = function()
            vim.g.NERDSpaceDelims = 1

            local keyset = vim.keymap.set
            keyset('n', '<c-/>', '<Plug>NERDCommenterToggle', { noremap = false, silent = true })
            keyset('v', '<c-/>', '<Plug>NERDCommenterToggle', { noremap = false, silent = true })
            keyset('i', '<c-/>', '<Esc><Plug>NERDCommenterTogglei', { noremap = false, silent = true })
        end
    }
}
