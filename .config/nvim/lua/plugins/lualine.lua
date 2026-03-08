return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin', -- It will match your theme automatically!
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {{'filename', path = 1}}, -- 'path = 1' shows relative path
          lualine_x = {'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  }
}
