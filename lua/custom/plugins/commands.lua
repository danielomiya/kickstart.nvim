vim.api.nvim_create_user_command('CopyRelPath', function()
  local path = vim.fn.expand '%:~:.'
  vim.fn.setreg('+', path)
  vim.notify(string.format('Copied "%s" to the clipboard!', path))
end, {})

return {}
