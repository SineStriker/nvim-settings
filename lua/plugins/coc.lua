return {
    {
        'neoclide/coc.nvim',
        branch = 'release',
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/lsp-status.nvim",
        },
        config = function()
            -- lspconfig
            require('lspconfig').clangd.setup{}




            -- lspstatus
            local lsp_status = require('lsp-status')
            -- completion_customize_lsp_label as used in completion-nvim
            -- Optional: customize the kind labels used in identifying the current function.
            -- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind 
            -- to the string you want to display as a label
            -- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

            -- Register the progress handler
            lsp_status.register_progress()




            -- coc

            -- https://github.com/neoclide/coc.nvim?tab=readme-ov-file#example-lua-configuration

            -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
            -- delays and poor user experience
            vim.opt.updatetime = 100
            
            local keyset = vim.keymap.set

            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
            keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
            keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

            -- Use <c-j> to trigger snippets
            keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <c-o> to trigger completion
            keyset("i", "<c-o>", "coc#refresh()", {silent = true, expr = true})

            -- Use K to show documentation in preview window
            -- function _G.show_docs()
            --     local cw = vim.fn.expand('<cword>')
            --     if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
            --         vim.api.nvim_command('h ' .. cw)
            --     elseif vim.api.nvim_eval('coc#rpc#ready()') then
            --         vim.fn.CocActionAsync('doHover')
            --     else
            --         vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
            --     end
            -- end
            -- keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

            -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })

            -- Symbol renaming
            keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

            -- Update signature help on jump placeholder
            vim.api.nvim_create_autocmd("User", {
                group = "CocGroup",
                pattern = "CocJumpPlaceholder",
                command = "call CocActionAsync('showSignatureHelp')",
                desc = "Update signature help on jump placeholder"
            })

            -- Customize
            -- Ctrl+Alt+L: Format Document
            keyset('i', '<a-s-f>', '<Esc>:CocCommand editor.action.formatDocument<CR>i', { noremap = true, silent = true })
            
            -- Ctrl+K: Show documentation
            keyset('i', '<c-k>', '<Esc>Ki', { noremap = true, silent = true })

            -- vim.cmd("autocmd! CursorHoldI * norm :call CocAction('DiagnosticInfo')<cr>")
        end
    },
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
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {
                disable_filetype = { "TelescopePrompt" }
            }
        end
    }
}
