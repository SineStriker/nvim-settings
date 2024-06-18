return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup {
                options = {
                    -- 左侧让出 nvim-tree 的位置
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Explorer",
                            highlight = "Directory",
                            text_align = "left"
                        }
                    }
                }
            }
        end
    }
}
