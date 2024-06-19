return {
    {
        'voldikss/vim-floaterm',
        config = function()
            local keyset = vim.keymap.set
            keyset('n', '<leader>ftt', ':FloatermToggle<CR>', { noremap = true, silent = true })
        end
    }
}
