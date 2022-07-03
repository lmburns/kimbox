local luacache = (_G.__luacache or {}).cache

for pack, _ in pairs(package.loaded) do
    if pack:match("^kimbox") then
        if not pack:match("config") then
            package.loaded[pack] = nil

            if luacache then
                luacache[pack] = nil
            end
        end
    end
end

require("kimbox").setup()
require("kimbox").colorscheme()
