local telescopeBuiltin = require ('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, {})
vim.keymap.set("n", "<leader>lg", telescopeBuiltin.live_grep, {})
