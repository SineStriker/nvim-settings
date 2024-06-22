return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'ojroques/nvim-bufdel'
        },
        config = function()
            require('bufdel').setup {
                next = 'tabs',
                quit = true,  -- quit Neovim when last buffer is closed
            }

            require("bufferline").setup {
                options = {
                    -- 左侧让出 nvim-tree 的位置
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Explorer",
                            highlight = "Directory",
                            separator = true,
                            text_align = "left",
                        }
                    },

                    -- 覆盖关闭命令，默认关闭会直接把窗口关了，但我们只需要把当前缓冲区关闭
                    close_command = function(bufnum)
                        vim.cmd('BufDel ' .. bufnum)
                    end,
                    
                    right_mouse_command = function(bufnum)
                        vim.cmd('BufDel ' .. bufnum)
                    end,
                }
            }

            local keyset = vim.keymap.set
            local opt = { noremap = true, silent = true }

            -- Ctrl+Q 关闭
            keyset('n', '<c-q>', ':BufDel<CR>', opt)
        end
    }
}
