return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "go",
      "groovy",
      "json",
      "kotlin",
      "lua",
      "python",
      "powershell",
      "vim",
      "vimdoc",
      "yaml",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup(opts)
      return
    end

    require("nvim-treesitter").setup()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "bash", "c", "cpp", "cs", "go", "groovy", "json", "kotlin", "lua", "python", "ps1", "vim", "yaml" },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
