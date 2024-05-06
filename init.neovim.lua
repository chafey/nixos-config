local telescopeBuiltin = require ("telescope.builtin")
local harpoon = require("harpoon")
local harpoonmark = require("harpoon.mark")
local harpoonui = require("harpoon.ui")

harpoon.setup()

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, {})
vim.keymap.set("n", "<leader>lg", telescopeBuiltin.live_grep, {})

vim.keymap.set("n", "<leader>a", function() harpoonmark.add_file() end)
vim.keymap.set("n", "<C-e>", function() harpoonui:toggle_quick_menu() end)
vim.keymap.set("n", "<C-h>", function() harpoonui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() harpoonui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() harpoonui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() harpoonui.van_file(4) end)
