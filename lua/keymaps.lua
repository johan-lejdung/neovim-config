-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic floating panel" })

vim.keymap.set("n", "<leader>tw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "[T]oggle [w]rap" })

vim.keymap.set("n", "<leader>ts", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "[T]oggle whitespace [s]ymbols" })

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify(path)
end, { desc = "[Y]ank file [p]ath to clipboard" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Move between windows straight from terminal mode (e.g. out of the Claude Code pane).
-- Only the four directions are mapped so a bare <C-w> still reaches the terminal
-- process after `timeoutlen` (Claude Code uses it to delete the previous word).
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { desc = "Move focus to the right window" })
-- Same, for when Ctrl is still held on the second key.
vim.keymap.set("t", "<C-w><C-h>", "<C-\\><C-n><C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-w><C-j>", "<C-\\><C-n><C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-w><C-k>", "<C-\\><C-n><C-w>k", { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-w><C-l>", "<C-\\><C-n><C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set("i", "<C-d>", "<Del>", { desc = "Delete character in front of cursor" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })

-- Keymaps for moving selected text up and down
-- Normal mode
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
-- Insert mode
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
-- Visual mode
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Redo with U
vim.keymap.set("n", "U", "<C-r>", { silent = true })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
