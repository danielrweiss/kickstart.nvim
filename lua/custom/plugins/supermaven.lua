return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<C-y>',
        clear_suggestion = '<C-]>',
        next_suggestion = '<C-n>',
        previous_suggestion = '<C-p>',
        toggle_suggestion = '<C-x>',
      },
      disable_inline_completion = false,
      log_level = 'info',
    }
  end,
}
