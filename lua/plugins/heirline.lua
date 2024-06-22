return {
    {
        "rebelot/heirline.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            "SmiteshP/nvim-navic",
            "lewis6991/gitsigns.nvim"
        },
        -- You can optionally lazy-load heirline on UiEnter
        -- to make sure all required plugins and colorschemes are loaded before setup
        -- event = "UiEnter",
        config = function()
            -- navic
            local navic = require("nvim-navic")
            require("lspconfig").clangd.setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }



            -- gitsigns
            require('gitsigns').setup()



            local conditions = require("heirline.conditions")
            local utils = require("heirline.utils")
            local colors = {
                bright_bg = utils.get_highlight("Folded").bg,
                bright_fg = utils.get_highlight("Folded").fg,
                red = utils.get_highlight("DiagnosticError").fg,
                dark_red = utils.get_highlight("DiffDelete").bg,
                green = utils.get_highlight("String").fg,
                blue = utils.get_highlight("Function").fg,
                gray = utils.get_highlight("NonText").fg,
                orange = utils.get_highlight("Constant").fg,
                purple = utils.get_highlight("Statement").fg,
                cyan = utils.get_highlight("Special").fg,
                diag_warn = utils.get_highlight("DiagnosticWarn").fg,
                diag_error = utils.get_highlight("DiagnosticError").fg,
                diag_hint = utils.get_highlight("DiagnosticHint").fg,
                diag_info = utils.get_highlight("DiagnosticInfo").fg,
                git_del = utils.get_highlight("diffDeleted").fg,
                git_add = utils.get_highlight("diffAdded").fg,
                git_change = utils.get_highlight("diffChanged").fg,
            }

            local FileNameBlock = {
                -- let's first set up some attributes needed by this component and its children
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }
            -- We can now define some children separately and add them later
            
            local FileIcon = {
                init = function(self)
                    local filename = self.filename
                    local extension = vim.fn.fnamemodify(filename, ":e")
                    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
                end,
                provider = function(self)
                    return self.icon and (self.icon .. " ")
                end,
                hl = function(self)
                    return { fg = self.icon_color }
                end
            }
            
            local FileName = {
                init = function(self)
                    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
                    if self.lfilename == "" then self.lfilename = "[No Name]" end
                end,
                hl = { fg = utils.get_highlight("Directory").fg },
            
                flexible = 2,
            
                {
                    provider = function(self)
                        return self.lfilename
                    end,
                },
                {
                    provider = function(self)
                        return vim.fn.pathshorten(self.lfilename)
                    end,
                },
            }
            
            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = "[+]",
                    hl = { fg = "green" },
                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "",
                    hl = { fg = "orange" },
                },
            }
            
            -- Now, let's say that we want the filename color to change if the buffer is
            -- modified. Of course, we could do that directly using the FileName.hl field,
            -- but we'll see how easy it is to alter existing components using a "modifier"
            -- component
            
            local FileNameModifer = {
                hl = function()
                    if vim.bo.modified then
                        -- use `force` because we need to override the child's hl foreground
                        return { fg = "cyan", bold = true, force=true }
                    end
                end,
            }
            
            -- let's add the children to our FileNameBlock component
            FileNameBlock = utils.insert(FileNameBlock,
                FileIcon,
                utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
                { provider = " " },
                FileFlags,
                { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
            )

            local FileType = {
                provider = function()
                    return string.upper(vim.bo.filetype)
                end,
                hl = { fg = utils.get_highlight("Type").fg, bold = true },
            }
            local FileEncoding = {
                provider = function()
                    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
                    return enc ~= 'utf-8' and enc:upper()
                end
            }
            local FileFormat = {
                provider = function()
                    local fmt = vim.bo.fileformat
                    return fmt ~= 'unix' and fmt:upper()
                end
            }

            local FileSize = {
                provider = function()
                    -- stackoverflow, compute human readable file size
                    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
                    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
                    fsize = (fsize < 0 and 0) or fsize
                    if fsize < 1024 then
                        return fsize..suffix[1]
                    end
                    local i = math.floor((math.log(fsize) / math.log(1024)))
                    return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
                end
            }
            local FileLastModified = {
                -- did you know? Vim is full of functions!
                provider = function()
                    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
                    return (ftime > 0) and os.date("%c", ftime)
                end
            }

            -- -- We're getting minimalist here!
            -- local Ruler = {
            --     -- %l = current line number
            --     -- %L = number of lines in the buffer
            --     -- %c = column number
            --     -- %P = percentage through file of displayed window
            --     provider = "%7(%l/%3L%):%2c %P",
            -- }

            -- -- I take no credits for this! 🦁
            -- local ScrollBar ={
            --     static = {
            --         sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
            --         -- Another variant, because the more choice the better.
            --         -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
            --     },
            --     provider = function(self)
            --         local curr_line = vim.api.nvim_win_get_cursor(0)[1]
            --         local lines = vim.api.nvim_buf_line_count(0)
            --         local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
            --         return string.rep(self.sbar[i], 2)
            --     end,
            --     hl = { fg = "blue", bg = "bright_bg" },
            -- }

            -- local LSPActive = {
            --     condition = conditions.lsp_attached,
            --     update = {'LspAttach', 'LspDetach'},
            
            --     -- You can keep it simple,
            --     -- provider = " [LSP]",
            
            --     -- Or complicate things a bit and get the servers names
            --     provider = function()
            --         local names = {}
            --         for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            --             table.insert(names, server.name)
            --         end
            --         return " [" .. table.concat(names, " ") .. "]"
            --     end,
            --     hl = { fg = "green", bold = true },
            -- }

            -- -- I personally use it only to display progress messages!
            -- -- See lsp-status/README.md for configuration options.

            -- -- Note: check "j-hui/fidget.nvim" for a nice statusline-free alternative.
            -- local LSPMessages = {
            --     provider = require("lsp-status").status,
            --     hl = { fg = "gray" },
            -- }

            -- local Navic = {
            --     condition = function() return require("nvim-navic").is_available() end,
            --     provider = function()
            --         return require("nvim-navic").get_location({highlight=true})
            --     end,
            --     update = 'CursorMoved'
            -- }            

            -- local Diagnostics = {

            --     condition = conditions.has_diagnostics,
            
            --     static = {
            --         error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
            --         warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
            --         info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
            --         hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
            --     },
            
            --     init = function(self)
            --         self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            --         self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            --         self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            --         self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            --     end,
            
            --     update = { "DiagnosticChanged", "BufEnter" },
            
            --     {
            --         provider = "![",
            --     },
            --     {
            --         provider = function(self)
            --             -- 0 is just another output, we can decide to print it or not!
            --             return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            --         end,
            --         hl = { fg = "diag_error" },
            --     },
            --     {
            --         provider = function(self)
            --             return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            --         end,
            --         hl = { fg = "diag_warn" },
            --     },
            --     {
            --         provider = function(self)
            --             return self.info > 0 and (self.info_icon .. self.info .. " ")
            --         end,
            --         hl = { fg = "diag_info" },
            --     },
            --     {
            --         provider = function(self)
            --             return self.hints > 0 and (self.hint_icon .. self.hints)
            --         end,
            --         hl = { fg = "diag_hint" },
            --     },
            --     {
            --         provider = "]",
            --     },
            -- }

            -- local Git = {
            --     condition = conditions.is_git_repo,
            
            --     init = function(self)
            --         self.status_dict = vim.b.gitsigns_status_dict
            --         self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
            --     end,
            
            --     hl = { fg = "orange" },
            
            
            --     {   -- git branch name
            --         provider = function(self)
            --             return " " .. self.status_dict.head
            --         end,
            --         hl = { bold = true }
            --     },
            --     -- You could handle delimiters, icons and counts similar to Diagnostics
            --     {
            --         condition = function(self)
            --             return self.has_changes
            --         end,
            --         provider = "("
            --     },
            --     {
            --         provider = function(self)
            --             local count = self.status_dict.added or 0
            --             return count > 0 and ("+" .. count)
            --         end,
            --         hl = { fg = "git_add" },
            --     },
            --     {
            --         provider = function(self)
            --             local count = self.status_dict.removed or 0
            --             return count > 0 and ("-" .. count)
            --         end,
            --         hl = { fg = "git_del" },
            --     },
            --     {
            --         provider = function(self)
            --             local count = self.status_dict.changed or 0
            --             return count > 0 and ("~" .. count)
            --         end,
            --         hl = { fg = "git_change" },
            --     },
            --     {
            --         condition = function(self)
            --             return self.has_changes
            --         end,
            --         provider = ")",
            --     },
            -- }

            -- local DAPMessages = {
            --     condition = function()
            --         local session = require("dap").session()
            --         return session ~= nil
            --     end,
            --     provider = function()
            --         return " " .. require("dap").status()
            --     end,
            --     hl = "Debug"
            --     -- see Click-it! section for clickable actions
            -- }

            -- local TerminalName = {
            --     -- we could add a condition to check that buftype == 'terminal'
            --     -- or we could do that later (see #conditional-statuslines below)
            --     provider = function()
            --         local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
            --         return " " .. tname
            --     end,
            --     hl = { fg = "blue", bold = true },
            -- }

            -- local HelpFileName = {
            --     condition = function()
            --         return vim.bo.filetype == "help"
            --     end,
            --     provider = function()
            --         local filename = vim.api.nvim_buf_get_name(0)
            --         return vim.fn.fnamemodify(filename, ":t")
            --     end,
            --     hl = { fg = colors.blue },
            -- }

            -- local FileType = {
            --     provider = function()
            --         return string.upper(vim.bo.filetype)
            --     end,
            --     hl = { fg = utils.get_highlight("Type").fg, bold = true },
            -- }
            -- local FileEncoding = {
            --     provider = function()
            --         local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
            --         return enc ~= 'utf-8' and enc:upper()
            --     end
            -- }
            -- local FileFormat = {
            --     provider = function()
            --         local fmt = vim.bo.fileformat
            --         return fmt ~= 'unix' and fmt:upper()
            --     end
            -- }

            local Align = { provider = "%=" }
            local Space = { provider = " " }
            -- local DefaultStatusline = {
            --     Git, Space, Diagnostics, Align,
            --     Navic, DAPMessages, Align,
            --     LSPActive, Space, LSPMessages, Space, FileType, Space, Ruler, Space, ScrollBar
            -- }
            -- local InactiveStatusline = {
            --     condition = conditions.is_not_active,
            --     FileType, Align,
            -- }
            -- local SpecialStatusline = {
            --     condition = function()
            --         return conditions.buffer_matches({
            --             buftype = { "nofile", "prompt", "help", "quickfix" },
            --             filetype = { "^git.*", "fugitive" },
            --         })
            --     end,
            
            --     FileType, Space, HelpFileName, Align
            -- }
            -- local TerminalStatusline = {

            --     condition = function()
            --         return conditions.buffer_matches({ buftype = { "terminal" } })
            --     end,
            
            --     hl = { bg = "dark_red" },
            
            --     -- Quickly add a condition to the ViMode to only show it when buffer is active!
            --     { condition = conditions.is_active, ViMode, Space }, FileType, Space, TerminalName, Align,
            -- }

            -- local StatusLines = {

            --     hl = function()
            --         if conditions.is_active() then
            --             return "StatusLine"
            --         else
            --             return "StatusLineNC"
            --         end
            --     end,
            
            --     -- the first statusline with no condition, or which condition returns true is used.
            --     -- think of it as a switch case with breaks to stop fallthrough.
            --     fallthrough = false,
            
            --     SpecialStatusline, TerminalStatusline, InactiveStatusline, DefaultStatusline,
            -- }

            local WinBars = {
                fallthrough = false,
                {
                    -- A special winbar for terminals
                    condition = function()
                        return conditions.buffer_matches({ buftype = { "terminal" } })
                    end,
                    utils.surround({ "", "" }, "dark_red", {
                        FileType,
                        Space,
                        TerminalName,
                    }),
                },
                {
                    -- An inactive winbar for regular files
                    condition = function()
                        return not conditions.is_active()
                        -- and not conditions.buffer_matches({
                        --     filetype = { 'NvimTree', 'help' },
                        -- })
                    end,
                    utils.surround({ "", "" }, "bright_bg", { hl = { fg = "gray", force = true }, FileNameBlock }),
                },
                {
                    -- A winbar for regular files
                    -- condition = function()
                    --     return not conditions.buffer_matches({
                    --         filetype = { 'NvimTree', 'help' },
                    --     })
                    -- end,
                    utils.surround({ "", "" }, "bright_bg", FileNameBlock),
                }
            }
            
            require("heirline").setup({
                opts = {
                    colors = colors,
                },
                statusline = StatusLines,
                winbar = WinBars
            })
        end
    }
}