return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- post_restore_cmds = {
    --   function()
    --     local manager = require("neo-tree.sources.manager")
    --     local state = manager.get_state("buffers")
    --     require("neo-tree.sources.buffers.commands").refresh(state)
    --   end
    -- }
  }
}

