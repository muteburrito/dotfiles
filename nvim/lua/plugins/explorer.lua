return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<leader>f", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file" },
  },
  config = function()
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 34,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
      },
    })
  end,
}
