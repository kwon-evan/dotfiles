return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local theta = require('alpha.themes.theta').config
      require 'alpha'.setup(theta)
    end
  }
}
