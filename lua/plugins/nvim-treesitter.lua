return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context"
        },
        config = function () 
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html",
                    "cpp", "cmake", "json", "xml", "markdown", "doxygen"
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

            require("treesitter-context").setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }

            -- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
            vim.cmd [[
                augroup CustomColors
                    autocmd!
                    autocmd ColorScheme vscode hi @property                                     guifg=#DDBFFF
                    autocmd ColorScheme vscode hi @variable.parameter                           guifg=#CCCCCC
                    autocmd ColorScheme vscode hi @type.builtin                                 guifg=#569CD6

                    autocmd ColorScheme vscode hi @lsp.typemod.method.virtual.cpp               gui=italic
                    autocmd ColorScheme vscode hi @lsp.typemod.variable.fileScope               guifg=#6c95eb gui=bold
                    autocmd ColorScheme vscode hi @lsp.typemod.variable.globalScope             guifg=#6c95eb
                    autocmd ColorScheme vscode hi @lsp.type.macro                               guifg=#569cd6
                    autocmd ColorScheme vscode hi @lsp.type.namespace.cpp                       guifg=#4EC9B0
                    autocmd ColorScheme vscode hi @lsp.type.comment.cpp                         guifg=#808066
                    autocmd ColorScheme vscode hi @lsp.type.comment.c                           guifg=#808066

                    autocmd ColorScheme vscode hi @string.escape                                guifg=#FFD68F
                    autocmd ColorScheme vscode hi @keyword.directive                            guifg=#9A9A9A

                    autocmd ColorScheme vscode hi LspInlayHint                                  guifg=#969696 guibg=#2E2E2E
                    autocmd ColorScheme vscode hi CocInlayHint                                  guifg=#969696 guibg=#2E2E2E
                
                    autocmd ColorScheme vscode hi DiagnosticWarn                                guifg=#A28608
                augroup END
            ]]
        end
    }
}
