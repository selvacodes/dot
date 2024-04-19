return {{ -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup {
            n_lines = 500
        }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        require('mini.files').setup({
            mappings = {
                go_in = 'L',
                go_in_plus = 'l'
            },
            windows = {
                preview = false
            }
        })

        local minifiles_toggle = function(...)
            if not MiniFiles.close() then
                MiniFiles.open(...)
            end
        end
        local open_file = function(...)
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end

        local function open_file_root(data)
            -- local directory = vim.fn.isdirectory(data.file) == 1

            -- if not directory then
            --     return
            -- end

            -- -- change to the directory
            -- vim.cmd.cd(data.file)

            -- open the tree
            MiniFiles.open(vim.loop.cwd(), true)
        end
        vim.api.nvim_create_autocmd({"VimEnter"}, {
            callback = open_file_root
        })

        -- vim.keymap.set('n', '<leader>e', open_file_root, {
        --     desc = 'Open file manager'
        -- })
        vim.keymap.set('n', '-', minifiles_toggle, {
            desc = 'Open file manager'
        })
        -- vim.keymap.set('n', '<leader>e', open_file_root, {
        --     desc = 'Open file manager on root'
        -- })
        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesWindowOpen',
            callback = function(args)
                local win_id = args.data.win_id

                -- Customize window-local settings
                vim.wo[win_id].winblend = 15 
                vim.api.nvim_win_set_config(win_id, {
                    border = 'double'
                })
            end
        })

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        -- local statusline = require 'mini.statusline'
        -- -- set use_icons to true if you have a Nerd Font
        -- statusline.setup {
        --     use_icons = vim.g.have_nerd_font
        -- }

        -- -- You can configure sections in the statusline by overriding their
        -- -- default behavior. For example, here we set the section for
        -- -- cursor location to LINE:COLUMN
        -- ---@diagnostic disable-next-line: duplicate-set-field
        -- statusline.section_location = function()
        --     return '%2l:%-2v'
        -- end

        -- local map_split = function(buf_id, lhs, direction)
        --     local rhs = function()
        --         -- Make new window and set it as target
        --         local new_target_window
        --         vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
        --             vim.cmd(direction .. ' split')
        --             new_target_window = vim.api.nvim_get_current_win()
        --         end)

        --         MiniFiles.set_target_window(new_target_window)
        --     end

        --     -- Adding `desc` will result into `show_help` entries
        --     local desc = 'Split ' .. direction
        --     vim.keymap.set('n', lhs, rhs, {
        --         buffer = buf_id,
        --         desc = desc
        --     })
        -- end

        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'MiniFilesBufferCreate',
        --     callback = function(args)
        --         local buf_id = args.data.buf_id
        --         -- Tweak keys to your liking
        --         map_split(buf_id, 'ts', 'belowright horizontal')
        --         map_split(buf_id, 'tv', 'belowright vertical')
        --     end
        -- })

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end
}}
-- vim: ts=2 sts=2 sw=2 et
