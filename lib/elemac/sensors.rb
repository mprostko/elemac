# Sensors are described as 4 blocks of memory starting from offset 1864
# those sensors are set as: temp1, temp2, temp3, temp4, ph1... dunno about ph2 and redox
# measure is on +2. size of 17. so first reading is at 1864+2
# ph starts at 1864 + 4*17. +2 is the ph measure

require "elemac/sensor/temperature"
require "elemac/sensor/ph"
require "elemac/sensor/redox"

module Elemac
	class Sensors
		def initialize(device:)
			@device = device
			# TODO: check loaded sensors
			@temp1_available = true
			@temp2_available = false
			@temp3_available = false
			@temp4_available = false
			@ph1_available 	= true
			@ph2_available 	= false
		end
		def temp1
			throw 'Sensor temp1 unavailable' unless @temp1_available
			Sensor::Temperature.new(device: @device, index: 0, divider: 10.0)
		end
		def temp2
			throw 'Sensor temp2 unavailable' unless @temp2_available
			Sensor::Temperature.new(device: @device, index: 1, divider: 10.0)
		end
		def temp3
			throw 'Sensor temp3 unavailable' unless @temp3_available
			Sensor::Temperature.new(device: @device, index: 2, divider: 10.0)
		end
		def temp4
			throw 'Sensor temp4 unavailable' unless @temp4_available
			Sensor::Temperature.new(device: @device, index: 3, divider: 10.0)
		end
		def ph1
			throw 'Sensor ph1 unavailable' unless @ph1_available
			Sensor::Ph.new(device: @device, index: 4, divider: 100.0)
		end
		def ph2
			throw 'Sensor ph1 unavailable' unless @ph2_available
			Sensor::Ph.new(device: @device, index: 5, divider: 100.0)
		end
		#def rh
		#	throw 'Sensor rh unavailable' unless @ph2_available
		#	Sensor::Redox.new(device: @device, index: 6, divider: 100.0)
		#end
	end
end
