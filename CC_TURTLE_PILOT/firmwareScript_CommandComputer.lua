local DroneBaseClassCommandComputer = require "lib.tilt_ships.DroneBaseClassCommandComputer"

local quaternion = require "lib.quaternions"

local instance_configs = {}

local drone = DroneBaseClassCommandComputer(instance_configs)

function drone:customFlightLoopBehavior(customFlightVariables)
	self.target_rotation = quaternion.fromToRotation(self.target_rotation:localPositiveZ(),vector.new(0,1,0))*self.target_rotation
	self.target_global_position = vector.new(0,33,17)
end


drone:run()