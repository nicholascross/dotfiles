return {
  "mhartington/formatter.nvim",
  config = function()
    require('formatter').setup {
      filetype = {
        swift = {
          function()
            return {
              exe = "swiftformat",
              args = {
                "--indent", "4",
                "--maxwidth", "100",
                "--wrapcollections", "before-first",
                "--wrapparameters", "before-first",
                "--wrapconditions", "before-first",
                "--funcattributes", "prev-line",
                "--typeattributes", "prev-line",
                "--varattributes", "prev-line",
                "--stdinpath", vim.fn.expand("%:p"),
              },
              stdin = true
            }
          end
        }
      }
    }
  end
}

