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

            -- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
            vim.cmd [[
                augroup CustomColors
                    autocmd!
                    autocmd ColorScheme vscode hi @property                                     guifg=#DDBFFF
                    autocmd ColorScheme vscode hi @variable.parameter                           guifg=#CCCCCC
                    autocmd ColorScheme vscode hi @type.builtin.cpp                             guifg=#569CD6

                    autocmd ColorScheme vscode hi @lsp.typemod.method.virtual.cpp               gui=italic
                    autocmd ColorScheme vscode hi @lsp.typemod.variable.fileScope.cpp           guifg=#6c95eb gui=bold
                    autocmd ColorScheme vscode hi @lsp.typemod.variable.globalScope             guifg=#6c95eb
                    autocmd ColorScheme vscode hi @lsp.type.macro.cpp                           guifg=#569cd6
                    autocmd ColorScheme vscode hi @lsp.type.namespace.cpp                       guifg=#4EC9B0
                    autocmd ColorScheme vscode hi @lsp.type.comment.cpp                         guifg=#808066
                    autocmd ColorScheme vscode hi @string.escape.cpp                            guifg=#FFD68F

                    autocmd ColorScheme vscode hi LspInlayHint                                  guifg=#969696 guibg=#2E2E2E
                    autocmd ColorScheme vscode hi CocInlayHint                                  guifg=#969696 guibg=#2E2E2E
                
                    autocmd ColorScheme vscode hi DiagnosticWarn                                guifg=#A28608
                augroup END
            ]]
        end
    }
}
