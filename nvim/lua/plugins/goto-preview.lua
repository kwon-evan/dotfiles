return {
  {
    'rmagatti/goto-preview',
    opts = function()
      require('goto-preview').setup {
        height = 45,
        default_mappings = true,
      }
    end
  }
}
