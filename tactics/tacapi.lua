require "vec2"

API = {} -- Tactics API

-- Events
API.Event = {}
API.Event.Type = {stateChange = 0, message = 1}

function API.Event.Count()
    return 0
end

function API.Event.Poll()
    return nil
end

-- TODO

-- Game State (0x)
API.Game = {}

function API.Game.State() -- Get Game State
    return c_api(0)
end

-- TODO

-- Objects Position (1x)
API.Locate = {}

function API.Locate.Teammate(id) -- Get Teammate Position
    return Vec2(c_api(10, id))
end

function API.Locate.Opp(id) -- Get Opponent Position
    return Vec2(c_api(11, id))
end

function API.Locate.Ball() -- Get Ball Position
    return Vec2(c_api(12))
end

-- Robot Control (2x)
API.Robot = {}

function API.Robot.Move(direction, speed)
    c_api(20, direction, speed)
end

function API.Robot.Turn(direction)
end

function API.Robot.Kick(angle, force)
    c_api(21, angle, force)
end

-- Communication (3x)
API.Comms = {}

function API.Comms.Send(id, message) -- Send Message to Teammate
    c_api(30, id, message)
end

-- receive options