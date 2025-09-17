--For Balyena SandSkiff VS+Kontraption MC 1.20.1 and 1.18.2
--Watch this tutorial video on how to use this class: https://youtu.be/t7hRWTVeBWA
local DroneBaseClassKontraption = require "lib.tilt_ships.DroneBaseClassKontraption"

local quaternion = require "lib.quaternions"

local instance_configs = {
	ship_constants_config = {
		PID_SETTINGS= {
			POS = { --Kontraption based omni-drones don't need a PID controller for rotation. Gyro Blocks control the rotation instead
				P=0.05,
				I=0.001,
				D=0.015,
			},
		},
		ION_THRUSTERS_COUNT = { --number of ion thrusters pointing in each cardinal direction
        	pos=vector.new(26,26,12), 	-- +X, +Y, +Z	-- this is how many ion thrusters Balyena has
        	neg=vector.new(26,26,12)	-- -X, -Y, -Z
    	},
	}
}

local drone = DroneBaseClassKontraption(instance_configs)

-- Watch this tutorial video to learn how to use this function: https://youtu.be/07Czgxqp0dk?si=gltpueMIgFjHpqJZ&t=269 (skip to 4:29)
function drone:getOffsetDefaultShipOrientation(default_ship_orientation)
	return quaternion.fromRotation(default_ship_orientation:localPositiveY(), -90)*default_ship_orientation -- Rotates the default orientation so that the nose of the ship is aligned with it's local +X axis
end

-- Watch this tutorial video to learn how to use this function: https://youtu.be/07Czgxqp0dk?si=gltpueMIgFjHpqJZ&t=269 (5:25 to 10:30)
function drone:customFlightLoopBehavior(customFlightVariables)
	self.target_rotation = quaternion.fromToRotation(self.target_rotation:localPositiveX(),vector.new(0,0,1))*self.target_rotation
	--self.target_rotation = quaternion.fromToRotation(self.target_rotation:localPositiveY(),vector.new(0,-1,0))*self.target_rotation -- uncomment to flip ship upside down
	self.target_global_position = vector.new(X,Y,Z) --replace XYZ with world coordinates
end

drone:run()
