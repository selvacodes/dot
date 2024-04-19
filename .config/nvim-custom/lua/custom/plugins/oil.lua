return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local oil = require("oil")
        oil.setup()
        local float_oil = function()
            oil.toggle_float()
        end

        vim.keymap.set("n", "<leader>e", float_oil, {
            desc = "Open parent directory"
        })
    end
}
