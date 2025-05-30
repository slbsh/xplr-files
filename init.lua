version = "1.0.0"
xplr.config.general.show_hidden = true

xplr.config.general.initial_layout = "no_help_no_selection"


-- plugin manager
local home = os.getenv("HOME")
package.path = 
   home .. "/.config/xplr/plugins/?/init.lua;" .. 
   home .. "/.config/xplr/plugins/?.lua;" .. 
   package.path

require("material-landscape2").setup()
require("tree").setup({ 
	as_initial_layout = true,
	toggle_layout_key = "",
})
require("map").setup({ editor = "nvim", editor_key = "ctrl-e" })
require("find").setup()


table.remove(xplr.config.general.table.row.cols, 5)

xplr.config.general.table.header.cols = {
   { format = "index"},
   { format = "path" },
   { format = "perm" },
   { format = "size" },
}

xplr.config.modes.builtin.default.key_bindings.on_key["esc"] = {
	help = "quit",
	messages = { "Quit" },
}
