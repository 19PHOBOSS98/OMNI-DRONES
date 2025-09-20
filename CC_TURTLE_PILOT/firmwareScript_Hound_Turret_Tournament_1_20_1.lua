--For Hound Turret using VS+Tournament 1.20.1 
--the get_thruster API still isn't implemented in the 1.20.1 version
--but I made it so that you can add the thruster list manually

--Watch this tutorial video on how to use this class: https://youtu.be/07Czgxqp0dk

local DroneBaseClassSP = require "lib.tilt_ships.DroneBaseClassSP"
local HoundTurretArsNouveauMagitech = require "lib.tilt_ships.HoundTurretArsNouveauMagitech"
local HoundTurretArsNouveauMagitech1201 = require "lib.tilt_ships.HoundTurretArsNouveauMagitech1201"

local quaternion = require "lib.quaternions"

local instance_configs = {
	ship_constants_config = {
		DRONE_ID = ship.getId(),
		PID_SETTINGS=
		{
			POS = {
				P = 0.7,
				I = 0.001,
				D = 1.5
			},
			ROT = {
				X = {
					P = 0.04,
					I = 0.001,
					D = 0.05
				},
				Y = {
					P = 0.04,
					I = 0.001,
					D = 0.07
				},
				Z = {
					P = 0.04,
					I = 0.001,
					D = 0.05
				}
			}
		},
	},
	channels_config = {
		DEBUG_TO_DRONE_CHANNEL = 9,
		DRONE_TO_DEBUG_CHANNEL = 10,
		
		REMOTE_TO_DRONE_CHANNEL = 7,
		DRONE_TO_REMOTE_CHANNEL = 8,
		
		DRONE_TO_COMPONENT_BROADCAST_CHANNEL = 800,
		COMPONENT_TO_DRONE_CHANNEL = 801,
		
		EXTERNAL_AIM_TARGETING_CHANNEL = 1009,
		EXTERNAL_ORBIT_TARGETING_CHANNEL = 1010,
		EXTERNAL_GOGGLE_PORT_CHANNEL = 1011,
		REPLY_DUMP_CHANNEL = 10000,
	},
}




---------------------------------VS TOURNAMENT STUFF---------------------------------




local drone = DroneBaseClassSP:subclass()

function drone:getThrusterList()--override to manually list down VS Tournament thrusters here
	--pos should be relative to the center of mass
	--force should be base ThrusterSpeed times thrusterTier
	--check your .minecraft\config\valkyrienskies\vs_tournament_server.json > thrusterSpeed for the base thruster force. It's 10000 by default
	--you're suppose to multiply it with the thruster tier number; press F3 and point at the thruster to see its tier number at the right side of the screen
	--They don't need to be organized here, just make sure that their pos and force properties are correct
	return {
		{pos={x=0,y=2,z=0},force={x=0,y=10000*2,z=0}},
		{pos={x=0,y=1,z=1},force={x=10000,y=0,z=0}},
		{pos={x=1,y=1,z=0},force={x=0,y=0,z=10000}},
		{pos={x=0,y=1,z=-1},force={x=-10000,y=0,z=0}},
		{pos={x=-1,y=1,z=0},force={x=0,y=0,z=-10000}},
		{pos={x=0,y=-2,z=0},force={x=0,y=-10000*2,z=0}},
		{pos={x=0,y=-1,z=1},force={x=10000,y=0,z=0}},
		{pos={x=1,y=-1,z=0},force={x=0,y=0,z=10000}},
		{pos={x=0,y=-1,z=-1},force={x=-10000,y=0,z=0}},
		{pos={x=-1,y=-1,z=0},force={x=0,y=0,z=-10000}},
	}
end

function drone:organizeThrusterTable(thruster_table)
	local new_thruster_table = {}

	for i,thruster in pairs(thruster_table) do
		new_thruster_table[1+#new_thruster_table] = {}
	end
	
	for i,thruster in pairs(thruster_table) do
		local dir = thruster.direction
		local rad = thruster.radius
		
		local isBow = rad.y > 0
		local idx_offset = isBow and 0 or 5

		if(dir.y > 0) then
			new_thruster_table[1] = thruster
		elseif (dir.y < 0) then
			new_thruster_table[6] = thruster
		elseif (dir.x > 0) then--east facing +X
			new_thruster_table[2+idx_offset] = thruster
		elseif (dir.x < 0) then--west facing -X
			new_thruster_table[3+idx_offset] = thruster
		elseif (dir.z > 0) then--south facing +Z
			new_thruster_table[4+idx_offset] = thruster
		elseif (dir.z < 0) then--north facing -Z
			new_thruster_table[5+idx_offset] = thruster
		end
	end
	-- local h = fs.open("./input_thruster_table/new_thruster_table.json","w")
	-- h.writeLine(textutils.serialise(new_thruster_table))
	-- h.flush()
	-- h.close()

	return new_thruster_table
end

--Redstone Integrators
local RSI_TOP = peripheral.wrap("top")
local RSI_BOTTOM = peripheral.wrap("bottom")

function drone:powerThrusters(component_redstone_power)
	if(type(component_redstone_power) == "number")then
		RSI_TOP.setAnalogOutput("up", component_redstone_power)      -- +Y
		RSI_TOP.setAnalogOutput("south", component_redstone_power)   -- +X
		RSI_TOP.setAnalogOutput("north", component_redstone_power)   -- -X
		RSI_TOP.setAnalogOutput("east", component_redstone_power)	-- +Z
		RSI_TOP.setAnalogOutput("west", component_redstone_power)	-- -Z

		RSI_BOTTOM.setAnalogOutput("down", component_redstone_power)  -- -Y 
		RSI_BOTTOM.setAnalogOutput("south", component_redstone_power) -- +X
		RSI_BOTTOM.setAnalogOutput("north", component_redstone_power) -- -X
		RSI_BOTTOM.setAnalogOutput("east", component_redstone_power)	-- +Z
		RSI_BOTTOM.setAnalogOutput("west", component_redstone_power)	-- -Z
	else
		RSI_TOP.setAnalogOutput("up", component_redstone_power[1])      -- +Y
		RSI_TOP.setAnalogOutput("south", component_redstone_power[2])   -- +X
		RSI_TOP.setAnalogOutput("north", component_redstone_power[3])   -- -X
		RSI_TOP.setAnalogOutput("east", component_redstone_power[4])	-- +Z
		RSI_TOP.setAnalogOutput("west", component_redstone_power[5])	-- -Z

		RSI_BOTTOM.setAnalogOutput("down", component_redstone_power[6])  -- -Y 
		RSI_BOTTOM.setAnalogOutput("south", component_redstone_power[7]) -- +X
		RSI_BOTTOM.setAnalogOutput("north", component_redstone_power[8]) -- -X
		RSI_BOTTOM.setAnalogOutput("east", component_redstone_power[9])	-- +Z
		RSI_BOTTOM.setAnalogOutput("west", component_redstone_power[10])	-- -Z
	end
end




---------------------------------HOUND TURRET STUFF---------------------------------




local hound = HoundTurretArsNouveauMagitech:subclass() -- I had to make a subclass to override some functions BEFORE creating an instance (before initializing the instance)

if(string.find(_HOST,"Minecraft 1.20.1")) then
	hound = HoundTurretArsNouveauMagitech1201:subclass() -- Hound Turrets work differently in 1.20.1. It uses hexcasting to speedup the spell bullets
end

function hound:alternateFire(step)
	local seq_1 = step==0
	local seq_2 = step==1
	--{modem_block, redstoneIntegrator_side}
	self:activateAllGuns({"top","right"},seq_1)
	self:activateAllGuns({"top","back"},seq_1)
	self:activateAllGuns({"top","top"},seq_2)
end

function hound:setShipFrameClass(configs) --override this to set ShipFrame Template
	--self.ShipFrame = DroneBaseClassKontraption(configs)	
	self.ShipFrame = drone(configs)
end

local customDrone = hound(instance_configs)

customDrone:run()
