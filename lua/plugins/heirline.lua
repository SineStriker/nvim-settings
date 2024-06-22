return {
    {
        "rebelot/heirline.nvim",
        -- You can optionally lazy-load heirline on UiEnter
        -- to make sure all required plugins and colorschemes are loaded before setup
        -- event = "UiEnter",
        config = function()
            local configs = require("heirline")
            configs.setup({})
        end
    }
}