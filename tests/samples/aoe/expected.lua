-- Generated by PS SimC Parser
local PS = ...
local Spell = PS.Spell
local Player = PS.Player
local Target = Player.Target
local Enemies = Player.Enemies
local Cache = {}

-- Initialize cache
function Cache:Get(key, default)
    return self[key] or default
end

function Cache:Set(key, value)
    self[key] = value
end

local Rotation = {
    Name = "AOE",
    Profile = "VDH-AOE",
    Class = "demonhunter",
    Spec = "vengeance",
    Role = "tank",
    Cache = Cache,
}

function Rotation:Execute()
    -- Check if we have a valid target
    if not Target:Exists() or Target:IsDead() then
        return
    end
    
    -- Update variables
    Cache:Set("large_pull", Enemies:Count() >= 5)
    Cache:Set("use_defensives", Cache:Get("large_pull") or Player:IncomingDamage(5) > 100000)
    
    -- Cast Spirit Bomb on 3+ targets
    if Spell.SpiritBomb:IsReady() and Player.SoulFragments >= 4 and Enemies:Count() >= 3 then
        return Cast(Spell.SpiritBomb)
    end
    
    -- Cast Immolation Aura on 2+ targets
    if Spell.ImmolationAura:IsReady() and Enemies:Count() > 1 then
        return Cast(Spell.ImmolationAura)
    end
    
    -- Cast Sigil of Flame on 2+ targets
    if Spell.SigilOfFlame:IsReady() and Enemies:Count() >= 2 then
        return Cast(Spell.SigilOfFlame)
    end
    
    -- Cast Fel Devastation on 3+ targets
    if Spell.FelDevastation:IsReady() and Enemies:Count() >= 3 then
        return Cast(Spell.FelDevastation)
    end
    
    -- Cast Soul Cleave on 1-2 targets
    if Spell.SoulCleave:IsReady() and Player.Fury >= 60 and Enemies:Count() <= 2 then
        return Cast(Spell.SoulCleave)
    end
    
    -- Cast Fracture as filler
    if Spell.Fracture:IsReady() then
        return Cast(Spell.Fracture)
    end
end

return Rotation 