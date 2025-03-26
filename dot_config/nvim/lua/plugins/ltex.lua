-- Extends ltex-ls support to add items to local dictionnary with code action
return {
  "barreiroleo/ltex_extra.nvim",
  ft = { "markdown", "tex" },
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {},
}
