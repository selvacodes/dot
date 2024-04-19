return {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = function()
        return {
            content = {
                active = function()
                    local m = require("mini.statusline")

                    local fnamemodify = vim.fn.fnamemodify

                    local project_name = function()
                        local current_project_folder = fnamemodify(vim.fn.getcwd(), ":t")
                        local parent_project_folder = fnamemodify(vim.fn.getcwd(), ":h:t")
                        return parent_project_folder .. "/" .. current_project_folder
                    end

                    local lazy_plug_count = function()
                        local stats = require("lazy").stats()
                        return " " .. stats.count
                    end

                    local lazy_startup = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return " " .. ms .. "ms"
                    end

                    local lazy_updates = function()
                        return require("lazy.status").updates()
                    end

                    local wtf = function()
                        return require("wtf").get_status()
                    end

                    local arrow_indicator = function()
                        return require("arrow.statusline").text_for_statusline_with_icons()
                    end

                    local auto_format_indicator = function()
                        if vim.g.vin_autoformat_enabled then
                            return "󰉶 On"
                        else
                            return "󰉶 Off"
                        end
                    end

                    local mode, mode_hl = m.section_mode({
                        trunc_width = 120
                    })

                    local spell = vim.wo.spell and (m.is_truncated(120) and "S" or "SPELL") or ""
                    local wrap = vim.wo.wrap and (m.is_truncated(120) and "W" or "WRAP") or ""
                    local git = m.section_git({
                        trunc_width = 75
                    })
                    local diagnostics = m.section_diagnostics({
                        trunc_width = 75
                    })
                    local filename = m.section_filename({
                        trunc_width = 140
                    })
                    local searchcount = m.section_searchcount({
                        trunc_width = 75
                    })
                    local location = m.section_location({
                        trunc_width = 120
                    })
                    local fileinfo = m.section_fileinfo({
                        trunc_width = 120
                    })

                    return m.combine_groups({{
                        hl = mode_hl,
                        strings = {mode}
                    }, {
                        hl = "@function",
                        strings = {project_name(), git}
                    }, "%<", -- Mark general truncate point
                    {
                        hl = "Comment",
                        strings = {location, arrow_indicator(), diagnostics}
                    }, "%=", -- End left alignment
                    {
                        hl = "Normal",
                        strings = {searchcount}
                    }, {
                        hl = "Normal",
                        strings = (not m.is_truncated(120) and
                            {wtf(), wrap, spell, auto_format_indicator(), lazy_plug_count(), lazy_updates(),
                             lazy_startup()} or {})
                    }, {
                        hl = "Normal",
                        strings = {fileinfo}
                    }})
                end
            }
        }
    end,
    config = function(_, opts)
        require("mini.statusline").setup(opts)
        vim.opt.laststatus = 3
    end
}
