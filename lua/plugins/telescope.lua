return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-frecency.nvim",
        },
        config = function()
            local configs = require('telescope')
            configs.setup{
                defaults = {
                    layout_config = {
                      prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                }
            }
            configs.load_extension("frecency")

            local builtin = require('telescope.builtin')
            local keyset = vim.keymap.set
            local opts = { noremap = true, silent = true }
            keyset('n', '<leader>ff', builtin.find_files, opts)
            keyset('n', '<leader>fg', builtin.live_grep, opts)
            keyset('n', '<leader>fb', builtin.buffers, opts)
            keyset('n', '<leader>fh', builtin.help_tags, opts)
            keyset('n', '<leader>fw', builtin.current_buffer_fuzzy_find, opts)

            keyset('n', '<leader>fc', builtin.commands, opts)
        end
    }
}
