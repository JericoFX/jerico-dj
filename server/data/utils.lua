-- https://github.com/overextended/ox_core/blob/main/shared/class.lua

local private_mt = {
    __ext = 0,
    __pack = function() return '' end,
}
local Class = {}

---@generic T
---@param prototype T
---@return { new: fun(obj): T}
function Class.new(prototype)
    local class = {
        __index = prototype
    }

    function class.new(obj)
        if obj.private then
            setmetatable(obj.private, private_mt)
        end

        return setmetatable(obj, class)
    end

    return class
end

return Class