-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local function open_neotree(data)
  local is_dir = vim.fn.isdirectory(data.file) == 1

  if not is_dir then
    return
  end

  vim.cmd.cd(data.file)
  vim.cmd('Neotree reveal left')
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
  lazy = false,
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

    vim.api.nvim_create_autocmd('VimEnter', { callback = open_neotree })
  end,
}
