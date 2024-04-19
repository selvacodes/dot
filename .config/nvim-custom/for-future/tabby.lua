return {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        -- configs...
        vim.o.showtabline = 2
    end
}
