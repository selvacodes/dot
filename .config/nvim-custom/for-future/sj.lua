return {
    'woosaaahh/sj.nvim',
    config = function()
        local sj = require("sj")
        sj.setup()

        vim.keymap.set("n", "s", sj.run)
        vim.keymap.set("n", "<A-,>", sj.prev_match)
        vim.keymap.set("n", "<A-;>", sj.next_match)
        -- vim.keymap.set("n", "<localleader>s", sj.redo)

    end
}
