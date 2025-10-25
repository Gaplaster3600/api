--- 2D Vector
Vec2 = {
    x = 0,
    y = 0
}

-- TODO better constructor

function Vec2:New(args)
    local o = {x = 0, y = 0}

    if (args ~= nil) then
        if #args > 0 then
            o.x = args[1]
        end

        if #args > 1 then
            o.y = args[2]
        end
    end

    setmetatable(o, self)
    self.__index = self
    return o
end

function Vec2.__add(a, b)
    if (type(b) == "number") then
        return {x = a.x + b, y = a.y + b}
    end

    return {
        x = a.x + b.x,
        y = a.y + b.y
    }
end

function Vec2.__sub(a, b)
    if (type(b) == "number") then
        return {x = a.x - b, y = a.y - b}
    end

    return {
        x = a.x - b.x,
        y = a.y - b.y
    }
end

-- Arithmetic

function Vec2.__mul(a, b)
    if (type(b) == "number") then
        return {x = a.x * b, y = a.y * b}
    end

    return {
        x = a.x * b.x,
        y = a.y * b.y
    }
end

function Vec2.__div(a, b)
    if (type(b) == "number") then
        return {x = a.x / b, y = a.y / b}
    end

    return {
        x = a.x / b.x,
        y = a.y / b.y
    }
end

function Vec2.__mod(a, b)
    if (type(b) == "number") then
        return {x = a.x % b, y = a.y % b}
    end

    return {
        x = a.x % b.x,
        y = a.y % b.y
    }
end

function Vec2.__pow(a, b)
    if (type(b) == "number") then
        return {x = a.x ^ b, y = a.y ^ b}
    end

    return {
        x = a.x ^ b.x,
        y = a.y ^ b.y
    }
end

-- Comparison

function Vec2.__eq(a, b)
    if (type(b) == "number") then
        return a.x == b and a.y == b
    end

    return a.x == b.x and a.y == b.y
end

function Vec2.__ne(a, b)
    if (type(b) == "number") then
        return a.x ~= b and a.y ~= b
    end

    return a.x ~= b.x and a.y ~= b.y
end

function Vec2.__le(a, b)
    if (type(b) == "number") then
        return a.x <= b and a.y <= b
    end

    return a.x <= b.x and a.y <= b.y
end

function Vec2.__lt(a, b)
    if (type(b) == "number") then
        return a.x < b and a.y < b
    end

    return a.x < b.x and a.y < b.y
end

function Vec2.__ge(a, b)
    if (type(b) == "number") then
        return a.x >= b and a.y >= b
    end

    return a.x >= b.x and a.y >= b.y
end

function Vec2.__gt(a, b)
    if (type(b) == "number") then
        return a.x > b and a.y > b
    end

    return a.x > b.x and a.y > b.y
end

-- Indexing

function Vec2:_index(key)
    return (key == 1 and self.x) or (key == 2 and self.y) or nil
end

function Vec2:__newindex(key, value)
    if (key == 1) then
        self.x = value
    elseif (key == 2) then
        self.y = value
    end
end

-- Misc

function Vec2:__len()
    return math.sqrt(self.x ^ 2 + self.y ^ 2)
end

function Vec2:sum()
    return self.x + self.y
end

function Vec2:normalize()
    return self / #self
end

-- function Vec2:clamp(min, max)
-- end

function Vec2.dist(a, b)
    return math.sqrt(((a - b) ^ 2).sum())
end

function Vec2.dot(a, b)
    return a.x * b.x + a.y * b.y
end

function Vec2.lerp(a, b, blend)
    return {
        x = a.x + (b.x - a.x) * blend,
        y = a.y + (b.y - a.y) * blend
    }
end

-- TODO (The Laundry)
-- also TODO type checks