local luacache = (_G.__luacache or {}).cache

for pack, _ in pairs(package.loaded) do
    if pack:find("kimbox", 1, true) then
        package.loaded[pack] = nil

        if luacache then
            luacache[pack] = nil
        end
    end
end

require("kimbox").setup()
require("kimbox").colorscheme()
