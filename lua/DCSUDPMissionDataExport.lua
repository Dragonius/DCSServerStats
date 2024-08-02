-- Copyright 2016 Marcel Haupt
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http ://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- THis is a Modification of the original code from xcom at http://forums.eagle.ru/showthread.php?t=124715&highlight=create+statistics


if CbaconExp == nil then -- Protection against multiple references (typically wrong script installation)

    local UDPip = "127.0.0.1"
    local UDPport = "9182"

    package.path  = package.path .. ";.\\LuaSocket\\?.lua" .. ";.\\Scripts\\?.lua"
    package.cpath = package.cpath .. ";.\\LuaSocket\\?.dll"
    local socket = require("socket")

    -- Necessary tables for string instead of integers
    local SETCoalition = {
        [0] = "neutral",
        [1] = "red",
        [2] = "blue",
        [3] = "UNKNOWK1",
        [4] = "UNKNOWK2",
        [5] = "UNKNOWK3",
    }

    local SETGroupCat = {
        [0] = "neutral",
        [1] = "AIRPLANE",
        [2] = "HELICOPTER",
        [3] = "GROUND",
        [4] = "SHIP",
        [5] = "STRUCTURE",
        [6] = "UNKNOWK2",
        [7] = "UNKNOWK3",
    }

    local SETfield = { 
        [1] = "Time",
        [2] = "Event",
        [3] = "Initiator ID",
        [4] = "Initiator Coalition",
        [5] = "Initiator Group Category",
        [6] = "Initiator Type",
        [7] = "Initiator Player",
        [8] = "Weapon Category",
        [9] = "Weapon Name",
        [10] = "Target ID",
        [11] = "Target Coalition",
        [12] = "Target Group Category",
        [13] = "Target Type",
        [14] = "Target Player",
        [15] = "UNKNOWK1",
        [16] = "UNKNOWK2",
        [17] = "UNKNOWK3",
    }

    local SETWeaponCatName = {
        [0] = "SHELL",
        [1] = "MISSILE",
        [2] = "ROCKET",
        [3] = "BOMB",
        [4] = "UNKNOWK1",
        [5] = "UNKNOWK2",
        [6] = "UNKNOWK3",
    }

    local SETWcoalitionservice = {
        [0] = "ATC",
        [1] = "AWACS",
        [2] = "TANKER",
        [3] = "FAC",
        [4] = "UNKNOWK1",
        [5] = "UNKNOWK2",
        [6] = "UNKNOWK3",
    }

    local wEvent = {
        [0] = "S_EVENT_INVALID",
        [1] = "S_EVENT_SHOT",
        [2] = "S_EVENT_HIT",
        [3] = "S_EVENT_TAKEOFF",
        [4] = "S_EVENT_LAND",
        [5] = "S_EVENT_CRASH",
        [6] = "S_EVENT_EJECTION",
        [7] = "S_EVENT_REFUELING",
        [8] = "S_EVENT_DEAD",
        [9] = "S_EVENT_PILOT_DEAD",
        [10] = "S_EVENT_BASE_CAPTURED",
        [11] = "S_EVENT_MISSION_START",
        [12] = "S_EVENT_MISSION_END",
        [13] = "S_EVENT_TOOK_CONTROL",
        [14] = "S_EVENT_REFUELING_STOP",
        [15] = "S_EVENT_BIRTH",
        [16] = "S_EVENT_HUMAN_FAILURE",
        [17] = "S_EVENT_DETAILED_FAILURE",
        [18] = "S_EVENT_ENGINE_STARTUP",
        [19] = "S_EVENT_ENGINE_SHUTDOWN",
        [20] = "S_EVENT_PLAYER_ENTER_UNIT",
        [21] = "S_EVENT_PLAYER_LEAVE_UNIT",
        [22] = "S_EVENT_PLAYER_COMMENT",
        [23] = "S_EVENT_SHOOTING_START",
        [24] = "S_EVENT_SHOOTING_END",
        [25] = "S_EVENT_MARK_ADDED",
        [26] = "S_EVENT_MARK_CHANGE",
        [27] = "S_EVENT_MARK_REMOVED",
        [28] = "S_EVENT_KILL",
        [29] = "S_EVENT_SCORE",
        [30] = "S_EVENT_UNIT_LOST",
        [31] = "S_EVENT_LANDING_AFTER_EJECTION",
        [32] = "S_EVENT_PARATROOPER_LENDING",
        [33] = "S_EVENT_DISCARD_CHAIR_AFTER_EJECTION",
        [34] = "S_EVENT_WEAPON_ADD",
        [35] = "S_EVENT_TRIGGER_ZONE",
        [36] = "S_EVENT_LANDING_QUALITY_MARK",
        [37] = "S_EVENT_BDA",
        [38] = "S_EVENT_AI_ABORT_MISSION",
        [39] = "S_EVENT_DAYNIGHT",
        [40] = "S_EVENT_FLIGHT_TIME",
        [41] = "S_EVENT_PLAYER_SELF_KILL_PILOT",
        [42] = "S_EVENT_PLAYER_CAPTURE_AIRFIELD",
        [43] = "S_EVENT_EMERGENCY_LANDING",
        [44] = "S_EVENT_UNIT_CREATE_TASK",
        [45] = "S_EVENT_UNIT_DELETE_TASK",
        [46] = "S_EVENT_SIMULATION_START",
        [47] = "S_EVENT_WEAPON_REARM",
        [48] = "S_EVENT_WEAPON_DROP",
        [49] = "S_EVENT_UNIT_TASK_TIMEOUT",
        [50] = "S_EVENT_UNIT_TASK_STAGE",
        [52] = "S_EVENT_MAX",
        [53] = "S_EVENT_MAC_SUBTASK_SCORE",
        [54] = "S_EVENT_MAC_EXTRA_SCORE",
        [55] = "S_EVENT_MISSION_RESTART",
        [56] = "S_EVENT_MISSION_WINNER",
        [57] = "S_EVENT_POSTPONED_TAKEOFF",
        [58] = "S_EVENT_POSTPONED_LAND",
    }

-- not in use YET
-- [7] = "S_EVENT_REFUELING" ,
-- [10] = "S_EVENT_BASE_CAPTURED" ,
-- [11] = "S_EVENT_MISSION_START" ,
-- [12] = "S_EVENT_MISSION_END" ,
-- [13] = "S_EVENT_TOOK_CONTROL" ,
-- [14] = "S_EVENT_REFUELING_STOP" ,
-- [16] = "S_EVENT_HUMAN_FAILURE" ,
-- [17] = "S_EVENT_DETAILED_FAILURE" ,
-- [18] = "S_EVENT_ENGINE_STARTUP" ,
-- [19] = "S_EVENT_ENGINE_SHUTDOWN" ,
-- [20] = "S_EVENT_PLAYER_ENTER_UNIT" ,
-- [21] = "S_EVENT_PLAYER_LEAVE_UNIT" ,
-- [22] = "S_EVENT_PLAYER_COMMENT" ,
-- [23] = "S_EVENT_SHOOTING_START" ,
-- [24] = "S_EVENT_SHOOTING_END" ,
-- [25] = "S_EVENT_MARK_ADDED " ,
-- [26] = "S_EVENT_MARK_CHANGE" ,
-- [27] = "S_EVENT_MARK_REMOVED" ,
-- [28] = "S_EVENT_KILL" ,
-- [29] = "S_EVENT_SCORE" ,
-- [30] = "S_EVENT_UNIT_LOST" ,
-- [31] = "S_EVENT_LANDING_AFTER_EJECTION" ,
-- [32] = "S_EVENT_PARATROOPER_LENDING" ,
-- [33] = "S_EVENT_DISCARD_CHAIR_AFTER_EJECTION" ,
-- [34] = "S_EVENT_WEAPON_ADD" ,
-- [35] = "S_EVENT_TRIGGER_ZONE" ,
-- [36] = "S_EVENT_LANDING_QUALITY_MARK" ,
-- [37] = "S_EVENT_BDA" ,
-- [38] = "S_EVENT_AI_ABORT_MISSION" ,
-- [39] = "S_EVENT_DAYNIGHT" ,
-- [40] = "S_EVENT_FLIGHT_TIME" ,
-- [41] = "S_EVENT_PLAYER_SELF_KILL_PILOT" ,
-- [42] = "S_EVENT_PLAYER_CAPTURE_AIRFIELD" ,
-- [43] = "S_EVENT_EMERGENCY_LANDING" ,
-- [44] = "S_EVENT_UNIT_CREATE_TASK" ,
-- [45] = "S_EVENT_UNIT_DELETE_TASK" ,
-- [46] = "S_EVENT_SIMULATION_START" ,
-- [47] = "S_EVENT_WEAPON_REARM" ,
-- [48] = "S_EVENT_WEAPON_DROP" ,
-- [49] = "S_EVENT_UNIT_TASK_TIMEOUT" ,
-- [50] = "S_EVENT_UNIT_TASK_STAGE" ,
-- [51] = "S_EVENT_MAX" ,

    CbaconExp = {}

    function CbaconExp:onEvent(e)
        local InitID_ = ""
        local WorldEvent = wEvent[e.id]
        local InitCoa = ""
        local InitGroupCat = ""
        local InitType = ""
        local InitPlayer = ""
        local eWeaponCat = ""
        local eWeaponName = ""
        local TargID_ = ""
        local TargType = ""
        local TargPlayer = ""
        local TargCoa = ""
        local TargGroupCat = ""
        
        -- safe world event
        if WorldEvent == nil then
            WorldEvent = "S_EVENT_UNKNOWN"
        end
        
        -- Initiator variables
        if e.initiator then
            -- Check if e.initiator has the getName method and it's not nil
            if e.initiator.getName and e.initiator:getName() then
                if string.sub(e.initiator:getName(), 1, string.len("CARGO")) ~= "CARGO" then
                    -- safety - hit building or unmanned vehicle
                    if not e.initiator['getPlayerName'] then            
                        return
                    end
                        -- Get initiator player name or AI if NIL
                    if not e.initiator:getPlayerName() then
                        InitPlayer = "AI"
                    else
                        InitPlayer = e.initiator:getPlayerName()
                    end
                    -- Check Category of object
                    -- If no category
                    if not Object.getCategory(e.initiator) then
                        InitID_ = e.initiator.id_
                        InitCoa = SETCoalition[e.initiator:getCoalition()]
                        InitGroupCat = SETGroupCat[e.initiator:getCategory()]
                        InitType = e.initiator:getTypeName()
                    -- if Category is UNIT    
                    elseif Object.getCategory(e.initiator) == Object.Category.UNIT then
                        local InitGroup = e.initiator:getGroup()
                        InitID_ = e.initiator.id_
                        if InitGroup and InitGroup:isExist() then
                            InitCoa = SETCoalition[InitGroup:getCoalition()]
                            InitGroupCat = SETGroupCat[InitGroup:getCategory() + 1]
                        else
                            InitCoa = SETCoalition[e.initiator:getCoalition()]
                            InitGroupCat = SETGroupCat[e.initiator:getCategory()]
                        end
                        InitType = e.initiator:getTypeName()
                        -- Birth event airborne
                        if (e.id == world.event.S_EVENT_BIRTH) then
                            if (Object.inAir(e.initiator)) then
                                WorldEvent = "S_EVENT_BIRTH_AIRBORNE"
                            end
                        end
                    -- if Category is STATIC
                    elseif  Object.getCategory(e.initiator) == Object.Category.STATIC then
                        InitID_ = e.initiator.id_
                        InitCoa = SETCoalition[e.initiator:getCoalition()]
                        InitGroupCat = SETGroupCat[e.initiator:getCategory()]
                        InitType = e.initiator:getTypeName()
                    end
                end
            else
                InitID_ = "No Initiator"
                InitCoa = "No Initiator"
                InitGroupCat = "No Initiator"
                InitType = "No Initiator"
                InitPlayer = "No Initiator"
            end
        end

        -- Weapon variables    
        if e.weapon == nil then
            eWeaponCat = "No Weapon"
            eWeaponName = "No Weapon"
        else
            if (e.id == world.event.S_EVENT_EJECTION)
                eWeaponCat = "No Weapon"
                eWeaponName = "No Weapon"
            else
                local eWeaponDesc = e.weapon:getDesc()
                -- Check if eWeaponDesc is nil or its displayName is "Weapon doesn't exist"
                eWeaponCat = SETWeaponCatName[eWeaponDesc.category]
                eWeaponName = eWeaponDesc.displayName
            end
        end

        -- Target variables
        if e.target then
            if string.sub(e.target:getName(), 1, string.len("CARGO")) ~= "CARGO" then
                
                -- safety - hit building or unmanned vehicle
                if not e.target['getPlayerName'] then        
                    return
                end
            
                -- Get target player name or AI if NIL
                if not e.target:getPlayerName() then -- warning!
                    TargPlayer = "AI"
                else
                    TargPlayer = e.target:getPlayerName()
                end
            
                -- Check Category of object
                -- If no category
                if not Object.getCategory(e.target) then
                    TargID_ = e.target.id_
                    TargCoa = SETCoalition[e.target:getCoalition()]
                    TargGroupCat = SETGroupCat[e.target:getCategory()]
                    TargType = e.target:getTypeName()
                -- if Category is UNIT    
                elseif Object.getCategory(e.target) == Object.Category.UNIT then
                    local TargGroup = e.target:getGroup()
                    TargID_ = e.target.id_
                    
                    if TargGroup and TargGroup:isExist() then
                        TargCoa = SETCoalition[TargGroup:getCoalition()]
                        TargGroupCat = SETGroupCat[TargGroup:getCategory() + 1]
                    else
                        TargCoa = SETCoalition[e.target:getCoalition()]
                        TargGroupCat = SETGroupCat[e.target:getCategory()]
                    end
                    TargType = e.target:getTypeName()
                -- if Category is STATIC
                elseif  Object.getCategory(e.target) == Object.Category.STATIC then
                    TargID_ = e.target.id_
                    TargCoa = SETCoalition[e.target:getCoalition()]
                    TargGroupCat = SETGroupCat[e.target:getCategory()]
                    TargType = e.target:getTypeName()
                end
            elseif not e.target then
                TargID_ = "No target"
                TargCoa = "No target"
                TargGroupCat = "No target"
                TargType = "No target"
                TargPlayer = "No target"
            end
        end
        
        -- write events to table
        if e.id == world.event.S_EVENT_HIT 
        or e.id == world.event.S_EVENT_SHOT
        or e.id == world.event.S_EVENT_EJECTION
        or e.id == world.event.S_EVENT_BIRTH
        or e.id == world.event.S_EVENT_CRASH
        or e.id == world.event.S_EVENT_DEAD
        or e.id == world.event.S_EVENT_PILOT_DEAD
        or e.id == world.event.S_EVENT_LAND
        or e.id == world.event.S_EVENT_MISSION_START
        or e.id == world.event.S_EVENT_MISSION_END
        or e.id == world.event.S_EVENT_PLAYER_LEAVE_UNIT
        or e.id == world.event.S_EVENT_TAKEOFF then
        
            udp = socket.udp()
            udp:settimeout(0)
            udp:setpeername(UDPip, UDPport)
            
            local sendstr = math.floor(timer.getTime()) .. "," .. WorldEvent .. "," .. InitID_ .. "," .. InitCoa .. "," .. InitGroupCat .. "," .. InitType .. "," .. InitPlayer .. "," .. eWeaponCat .. "," .. eWeaponName .. "," .. TargID_ .. "," .. TargCoa .. "," .. TargGroupCat .. "," .. TargType .. "," .. TargPlayer
            -- env.info(sendstr, true)
            
            udp:send(sendstr)
        end
    end

    world.addEventHandler(CbaconExp)
end -- Protection against multiple references (typically wrong script installation)
