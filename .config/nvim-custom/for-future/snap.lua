return {
    "camspiers/snap",
    config = function()
        -- Basic example config
        local snap = require "snap"
        snap.maps {{"<leader>m", snap.config.file {
            producer = "ripgrep.file"
        }}}
    end
}
