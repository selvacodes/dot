return {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = {}, -- needed even when using default config,
    config = function()
        require("origami").setup({}) -- setup call needed
    end
    
}
