local M = {}

function M.path()
  local package_swift = vim.fn.findfile("Package.swift", ".;")
  if package_swift ~= "" then
    -- absolute path of directory containing the package file
    return vim.fn.fnamemodify(package_swift, ":p:h")
  end

  -- Package file not found
  return nil
end

function M.products(package_path)
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

return M
