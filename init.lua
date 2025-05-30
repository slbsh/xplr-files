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
require("tree").setup({ as_initial_layout = true })
require("map").setup({ editor = "nvim", editor_key = "ctrl-e" })
require("find").setup()


table.remove(xplr.config.general.table.row.cols, 5)

xplr.config.general.table.header.cols = {
   { format = "index"},
   { format = "path" },
   { format = "perm" },
   { format = "size" },
}


--
-- Bookmarks
xplr.config.modes.builtin.default.key_bindings.on_key.m = {
  help = "bookmark",
  messages = {
    {
      BashExecSilently0 = [===[
        PTH="${XPLR_FOCUS_PATH:?}"
        PTH_ESC=$(printf %q "$PTH")
        if echo "${PTH:?}" >> "${XPLR_SESSION_PATH:?}/bookmarks"; then
          "$XPLR" -m 'LogSuccess: %q' "$PTH_ESC added to bookmarks"
        else
          "$XPLR" -m 'LogError: %q' "Failed to bookmark $PTH_ESC"
        fi
      ]===],
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["`"] = {
  help = "go to bookmark",
  messages = {
    {
      BashExec0 = [===[
        PTH=$(cat "${XPLR_SESSION_PATH:?}/bookmarks" | fzf --no-sort)
        PTH_ESC=$(printf %q "$PTH")
        if [ "$PTH" ]; then
          "$XPLR" -m 'FocusPath: %q' "$PTH"
        fi
      ]===],
    },
  },
}
