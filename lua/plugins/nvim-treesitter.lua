return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground"
        },
        config = function () 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html",
                    "cpp", "cmake", "json", "xml", "markdown"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                },
            })

         vim.cmd [[
            augroup CustomColors
                autocmd!
                autocmd ColorScheme vscode highlight @property guifg=#DDBFFF
                " autocmd ColorScheme vscode highlight @comment guifg=#808066
                autocmd ColorScheme vscode highlight @variable.parameter guifg=#CCCCCC
                autocmd ColorScheme vscode highlight @module guifg=#4EC9B0
            augroup END
        ]]
        end
    }
}
