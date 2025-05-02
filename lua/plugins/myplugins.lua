local plugins = {
  -- Your existing plugins...

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
},
{
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "Makefile", "package.json", "Cargo.toml" },
    }
    require("telescope").load_extension("projects")  -- Optional Telescope support
  end
}

return plugins

