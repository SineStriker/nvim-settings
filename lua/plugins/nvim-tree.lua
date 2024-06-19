return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("nvim-tree").setup {
                filters = {
                    dotfiles = false,     -- 不隐藏 . 开头目录
                    custom = { ".git" }   -- 只隐藏 .git 目录
                },
                git = {
                    ignore = false,       -- 不忽略.gitignore中的文件和目录
                }
            }
        end
    }
}
