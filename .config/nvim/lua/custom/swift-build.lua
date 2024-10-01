local M = {}

local function is_swift_package()
  local package_swift = vim.fn.findfile("Package.swift", ".;")
  if package_swift ~= "" then
    return vim.fn.fnamemodify(package_swift, ":p:h")
  end
  return nil
end

local function get_swift_products(package_path)
  local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift package describe --type json"
  local output = vim.fn.system(cmd)
  local data = vim.fn.json_decode(output)
  local products = {}
  if data and data.products then
    for _, product in ipairs(data.products) do
      table.insert(products, product.name)
    end
  end
  return products
end

local function select_option(options, prompt, callback)
  vim.ui.select(options, { prompt = prompt }, function(selected)
    if not selected then
      vim.notify("Selection cancelled", vim.log.levels.WARN)
      return
    end
    callback(selected)
  end)
end

local function open_tracked_terminal(cmd, name)
    name = name or "Terminal"

    local existing_bufnr = vim.fn.bufnr(name)
    if existing_bufnr ~= -1 then
        vim.api.nvim_buf_delete(existing_bufnr, { force = true })
    end

    -- Run the command in a non-interactive shell that exits after execution
    local shell_cmd = string.format("terminal %s -c %s", vim.o.shell, vim.fn.shellescape(cmd))
    vim.cmd(shell_cmd)

    local terminal_bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(terminal_bufnr, name)

    -- Scroll to the bottom when the buffer updates
    vim.api.nvim_create_autocmd("BufEnter", {
        buffer = terminal_bufnr,
        callback = function()
            vim.cmd("normal! G")
        end,
    })

    vim.cmd("normal! G")
end

function M.build_swift_package()
  local package_path = is_swift_package()
  if not package_path then
    vim.notify("Not a Swift package", vim.log.levels.ERROR)
    return
  end
  local products = get_swift_products(package_path)
  if #products == 0 then
    vim.notify("No products found", vim.log.levels.ERROR)
    return
  end
  select_option(products, "Select Product to Build:", function(product)
    local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift build --product " .. vim.fn.shellescape(product)
    open_tracked_terminal(cmd, "swift build " .. product)
  end)
end

function M.run_swift_package()
  local package_path = is_swift_package()
  if not package_path then
    vim.notify("Not a Swift package", vim.log.levels.ERROR)
    return
  end
  local products = get_swift_products(package_path)
  if #products == 0 then
    vim.notify("No products found", vim.log.levels.ERROR)
    return
  end
  select_option(products, "Select Product to Run:", function(product)
    local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift run " .. vim.fn.shellescape(product)
    vim.cmd("terminal " .. cmd)
    vim.cmd("terminal " .. cmd)
  end)
end

return M

