local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
local function open_floating_term(opts)
  opts = opts or {}
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.75)
  local height = math.floor(ui.height * 0.75)
  local col = math.floor((ui.width - width) / 2)
  local row = math.floor((ui.height - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  vim.cmd.terminal()
  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_floating_term { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('FloatTerm', toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<C-q>', toggle_terminal, { desc = 'Toggle terminal window' })
