return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() 
      -- We use pcall (protected call) to avoid the error screen if the module isn't ready
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then return end

      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "python", "bash" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}

