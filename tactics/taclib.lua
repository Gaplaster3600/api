require "tacapi"

-- require "gyro_data"
-- require "vec2"
-- require "movement"

Tacs = {}       -- Tacs Library

Tacs.Ball = {}      -- Ball Preferences

Tacs.Teammate = {}      -- Teammate Preferences

Tacs.Opponent = {}      -- Opponent Preferences

Tacs.GameState = {}     -- Store Game State

Tacs.Control = {}       -- Take Control

Tacs.Comms = {}         -- Robot Communication

Tacs.Formula = {}         -- Positions from each other

self_id = ""        -- The Robot's Own ID
tm_id = ""          -- The Teammate's ID
msg = ""            -- The Message about Formula
x = 0               -- X Coordinate of an Object
y = 0               -- Y Coordinate of an Object
role = ""           -- Role in a Specific Situation
gamerole = ""       -- GameRole in an entire Game (goalkeeper, striker)

function Tacs.Places(start_position, net, around_net, middle, corner, edge)     -- The Places Where A Robot Can Be
    return start_position, net, around_net, middle, corner, edge
end

function Tacs.Ball.Position(x, y)       -- Ball Place
    return x, y
end

function Tacs.Ball.FromMe(in_sight, distance, direction)       -- Ball Location
    if in_sight == true then        -- If Ball is Visible to the Robot
        -- Robot.Move(real_vec)
    end
    return in_sight, distance, direction
end

function Tacs.Ball.Out(goalline, touchline, faulty)     -- If The Ball Is Out
    if faulty ~= self_id and faulty ~= tm_id then       -- If The Opponent Kicked Out The Ball
        if goalline == true then        -- If it Went Out of the Goalline
            -- Robot.MoveTo(corner)
        else
            -- Robot.MoveTo(edge)
        end    
    else                            -- If We Are The Faulties
        if goalline == true then
            -- Robot.MoveTo(net)            -- Go Back To Defend
        else
            -- Robot.MoveTo(start_position)
        end
    end
    return goalline, touchline
end

function Tacs.MyPosition(x, y)      -- The Robots Own Position and Coordinates
    return x, y
end

function Tacs.Teammate.Position(x, y)       -- Teammate Place
    return x, y
end

function Tacs.Teammate.FromMe(in_sight, direction, distance)        -- Teammate Location
    if in_sight == true then
        -- Tacs.Formula.Passing(direction, force)
    end
    return in_sight, direction, distance
end

function Tacs.Opponent.FromMe(in_sight, direction, distance)        -- Opponent Location
    if in_sight == true then
        -- Tacs.Kick(dif_dir, force)
    end
    return in_sight, direction, distance
end

function Tacs.GameState.ifOn(isOn)      -- Game State
    if isOn == true then
        -- Tacs.GameState.Start()   
    end
    return isOn
end

function Tacs.GameState.Start(position, direction, ball)        -- When The Game Starts
    -- Robot.Move(direction, ball)
    return position, direction, ball
end

function Tacs.GameState.Stop(position)      -- When The Game is Stopped
    -- Robot.MoveTo(start_position)
    -- Robot.Move.Stop()
end

function Tacs.Control.GiveControl(id, role)     -- Giving Control
    while role == "receiver" do     -- If I Am The Receiver
        Tacs.Comms.ReceiveMsg()     
        if msg == "pass" then           -- If you get a command to pass-play, then do that
            Tacs.Formula.Passing()
        elseif msg == "commit" then     -- If you get command to commit, then do that
            Tacs.Formula.Commit()
        elseif msg == "line" then       -- If you get command to move in line, then do that
            Tacs.Formula.Line()
        else                        -- in every other scenario, move to the back to play defense
            Tacs.Formula.Defend()
        end
        return id, role
    end
end

function Tacs.Control.TakeControl(id, role)      -- Taking Control
    while role == "commander" do    -- If I Am The Observer and The Captain At The Moment
        Tacs.Comms.SendMsg()
        if Tacs.Teammate.Position(y) > 200 and Tacs.Teammate.FromMe() == true and Tacs.Ball.FromMe() == true then   
            Tacs.Comms.SendMsg(tm_id, "pass")       -- If Both Robots are beyond the midfield
        elseif Tacs.MyPosition(y) < -200 and Tacs.Teammate.Position(y) < -200 and Tacs.Opponent.FromMe() == true then   
            Tacs.Comms.SendMsg(tm_id, "defend")     -- if they are back and the opponent is near
        elseif Tacs.MyPosition(y) > 200 and Tacs.Teammate.Position(y) > 200 and Tacs.Teammate.FromMe() == true  and Tacs.Ball.FromMe() == true then 
            Tacs.Comms.SendMsg(tm_id, "commit")         -- If Commit is Possible(both robots are beyond midfield, and they are close to each other)
        else
            Tacs.Comms.SendMsg(tm_id, "line")       -- Else move in a straight line
        end
        return id, role
    end
end

function Tacs.Comms.SendMsg(id, msg)        -- Send Message
    return id, msg
end

function Tacs.Comms.ReceiveMsg(id, msg)     -- Receive Message
    return id, msg
end

function Tacs.Comms.PopMsg(msg, count)      -- Store Message Data
    return msg, count
end

function Tacs.Kick(angle, force)        -- Store Kick Properties
    -- Robot.Kick(45, 0.8)
    return angle, force
end

function Tacs.Role(tasks, position, isCaptain)         -- Store Robot Role in Soccer
    if isCaptain == true then
        role = "commander"
    else
        role = "receiver"
    end
    if gamerole == "keeper" then
        -- tasks = keeperTask()
        -- position = Tacs.Places(net)
    end
    return tasks, position, isCaptain
end

function Tacs.Formula.Line(position, distance)        -- Line Formula
    if Tacs.Teammate.Position(x) == 200 and Tacs.Teammate.Position(y) == -200 then
        -- Robot.MoveTo(-200, -200)
    else
        -- Robot.MoveTo(200, -200)
    end
    return position, distance
end

function Tacs.Formula.Commit(position, distance, direction, ball)       -- Commit Positions
    -- Robot.Kick(net_angle, 1)
    return position, distance, direction, ball
end

function Tacs.Formula.Defend(position, distance, direction, ball)       -- Play Defense
    -- Robot.MoveTo(around_net)
    return position, distance, direction, ball
end

function Tacs.Formula.Passing(position, distance, direction, ball)      -- Play Pass Game
    -- Robot.Kick(tm_angle, dis_force)
    return position, distance, direction, ball
end