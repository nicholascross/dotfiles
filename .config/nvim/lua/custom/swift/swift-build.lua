local terminal = require('custom/utils/terminal')
local swift_package = require('custom/swift/swift-package')

local M = {}

local function select_product(prompt, callback)
  local package_path = swift_package.path()

  if not package_path then
    vim.notify("Not a Swift package", vim.log.levels.ERROR)
    return
  end

  local products = swift_package.products(package_path)
  if #products == 0 then
    vim.notify("No products found", vim.log.levels.WARN)
    return
  end

  vim.ui.select(products, { prompt = prompt }, function(selected)
    if not selected then
      vim.notify("Selection cancelled", vim.log.levels.DEBUG)
      return
    end
    callback(package_path, selected)
  end)
end

function M.build_swift_package()
  select_product("Select Product to Build:", function(package_path, product)
    local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift build --product " .. vim.fn.shellescape(product)
    terminal.open(cmd, "swift build " .. product)
  end)
end

function M.run_swift_package()
  select_product("Select Product to Run:", function(package_path, product)
    local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift run " .. vim.fn.shellescape(product)
    terminal.open(cmd, "swift run " .. product)
  end)
end

return M

