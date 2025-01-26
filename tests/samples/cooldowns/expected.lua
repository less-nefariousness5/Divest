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
    Name = "Cooldowns",
    Profile = "VDH-Cooldowns",
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
    Cache:Set("cooldown_condition", 
        Target:TimeToDie() > 30 and 
        not Cache:Get("mechanic_active")
    )
    Cache:Set("burst_condition",
        Player.Buff(Spell.Metamorphosis):Exists() or
        Target:TimeToDie() <= 25
    )
    
    -- Cast cooldowns
    if Spell.Metamorphosis:IsReady() and Cache:Get("cooldown_condition") then
        return Cast(Spell.Metamorphosis)
    end
    
    if Spell.FieryBrand:IsReady() and Cache:Get("cooldown_condition") and not Player.Buff(Spell.FieryBrand):Exists() then
        return Cast(Spell.FieryBrand)
    end
    
    -- Use trinkets during burst
    if Cache:Get("burst_condition") then
        if Player.Trinket1:IsReady() then
            return Cast(Player.Trinket1)
        end
        
        if Player.Trinket2:IsReady() then
            return Cast(Player.Trinket2)
        end
    end
    
    -- Regular abilities
    if Spell.FelDevastation:IsReady() and Player.Buff(Spell.Metamorphosis):Exists() then
        return Cast(Spell.FelDevastation)
    end
    
    if Spell.SpiritBomb:IsReady() and Player.Buff(Spell.Metamorphosis):Exists() and Player.SoulFragments >= 4 then
        return Cast(Spell.SpiritBomb)
    end
end

return Rotation 