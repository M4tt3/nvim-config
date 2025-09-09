
-- Modes you care about (n = normal, i = insert, v = visual, x = visual select, t = terminal, etc.)
local modes = { "n", "i", "v", "x", "t" }

local results = {}
for _, mode in ipairs(modes) do
  local maps = vim.api.nvim_get_keymap(mode)
  for _, map in ipairs(maps) do
    if map.lhs:find("") then
      table.insert(results, { mode = mode, lhs = map.lhs, rhs = map.rhs })
    end
  end
end

-- Print results
for _, m in ipairs(results) do
  print(string.format("[%s] %s -> %s", m.mode, m.lhs, m.rhs or ""))
end
