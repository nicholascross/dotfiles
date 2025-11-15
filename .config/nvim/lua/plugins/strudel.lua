return {
  "gruvw/strudel.nvim",
  build = "npm install",
  config = function()
    require("strudel").setup({
      -- Point Puppeteer to your Chrome executable on macOS
      browser_exec_path = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",

      -- Optional sensible defaults (feel free to tweak later)
      sync_cursor = true,
      report_eval_errors = true,
      update_on_save = false,
      -- browser_data_dir = vim.fn.expand("~/.cache/strudel-nvim/"),
      -- headless = false,
    })
  end,
}
