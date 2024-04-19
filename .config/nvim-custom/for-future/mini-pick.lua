local M = {
  'echasnovski/mini.pick',
  version = '*',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  opt = {},
  config = function()
    local pick = require 'mini.pick'
    pick.setup()
  end,
}

return M
