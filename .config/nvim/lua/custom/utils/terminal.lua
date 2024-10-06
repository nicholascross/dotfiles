local M = {}

function M.open(cmd, name)
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

    vim.cmd("normal! G")
end

return M
