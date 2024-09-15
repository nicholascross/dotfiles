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
    vim.cmd("terminal " .. cmd)
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
  end)
end

return M

