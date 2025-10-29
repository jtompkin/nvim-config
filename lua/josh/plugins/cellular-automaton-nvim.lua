vim.pack.add({ Lib.from_gh("Eandrju/cellular-automaton.nvim") })
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "Make it rain!" })
vim.keymap.set("n", "<leader>fmg", "<cmd>CellularAutomaton game_of_life<cr>", { desc = "Game of life!" })
vim.keymap.set("n", "<leader>fms", "<cmd>CellularAutomaton scramble<cr>", { desc = "Scramble!" })
