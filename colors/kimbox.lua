for k in pairs(package.loaded) do
  if k:match(".*kimbox.*") then
    package.loaded[k] = nil
  end
end

require("kimbox").setup()
require("kimbox").colorscheme()
