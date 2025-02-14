vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local EricKirchner_Fugitive = vim.api.nvim_create_augroup("EricKirchner_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = EricKirchner_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}

        -- fast forward always
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('pull --ff-only')
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);

        vim.keymap.set("n", "<leader>b", ":Git blame");
    end,
})
