-- Behaves like regular vim completion
-- C-n will select th next entry with no preselection
return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
    keymap = {
      ["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },
    },
  },
}
