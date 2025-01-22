-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local function open_nvim_tree(data)
  local dir = vim.fn.isdirectory(data.file) == 1

  if not dir then
    return
  end

  vim.cmd.cd(data.file)
  require('nvim-tree.api').tree.open()
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    'saifulapm/neotree-file-nesting-config',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    local opts = {
      hide_root_node = true,
      retain_hidden_root_indent = true,
      filesystem = {
        filtered_items = {
          never_show = { '.DS_Store' },
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
      default_components_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
        },
      },
    }
    opts.nesting_rules = require('neotree-file-nesting-config').nesting_rules
    require('neo-tree').setup(opts)

    vim.api.nvim_create_autocmd('VimEnter', { callback = open_nvim_tree })
  end,
}
