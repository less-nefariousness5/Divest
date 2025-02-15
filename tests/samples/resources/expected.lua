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
    Name = "Resources",
    Profile = "VDH-Resources",
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
    Cache:Set("max_fragments", 5)
    Cache:Set("need_fury", Player:FuryDeficit() >= 40)
    Cache:Set("need_fragments", Player.SoulFragments < Cache:Get("max_fragments") - 1)
    Cache:Set("overcap_fury", Player:FuryDeficit() <= 20 and not Player.Buff(Spell.Metamorphosis):Exists())
    
    -- Fury generation
    if Spell.Felblade:IsReady() and Cache:Get("need_fury") then
        return Cast(Spell.Felblade)
    end
    
    if Spell.ImmolationAura:IsReady() and Cache:Get("need_fury") then
        return Cast(Spell.ImmolationAura)
    end
    
    if Spell.Fracture:IsReady() and Cache:Get("need_fragments") and not Cache:Get("overcap_fury") then
        return Cast(Spell.Fracture)
    end
    
    -- Fury spending
    if Spell.SpiritBomb:IsReady() and Player.SoulFragments >= 4 then
        return Cast(Spell.SpiritBomb)
    end
    
    if Spell.SoulCleave:IsReady() and Cache:Get("overcap_fury") then
        return Cast(Spell.SoulCleave)
    end
end

return Rotation 