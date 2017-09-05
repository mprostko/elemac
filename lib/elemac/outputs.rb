require "elemac/output/power"
require "elemac/output/pwm"
require "elemac/output/ttl"

module Elemac
	class Outputs
		def initialize(device:)
			@device = device
			# TODO: check loaded sensors
			@out_a = @out_b = @out_c = @out_d = @out_e = true
			@out_f = true
			@out_g = true
			# more unavailable now
		end
		
		def out_a
			throw 'Output A unavailable' unless @out_a
			PowerOutput.new(device: @device, index: 0)
		end
		def out_b
			throw 'Output B unavailable' unless @out_b
			PowerOutput.new(device: @device, index: 1)
		end
		def out_c
			throw 'Output C unavailable' unless @out_c
			PowerOutput.new(device: @device, index: 2)
		end
		def out_d
			throw 'Output D unavailable' unless @out_d
			PowerOutput.new(device: @device, index: 3)
		end
		def out_e
			throw 'Output E unavailable' unless @out_e
			PowerOutput.new(device: @device, index: 4)
		end
		def out_f
			throw 'Output F unavailable' unless @out_f
			PwmOutput.new(device: @device, index: 5, dim_index: 0)
		end
		def out_g
			throw 'Output G unavailable' unless @out_g
			TtlOutput.new(device: @device, index: 6)
		end
		
		def outputs_available
			['a','b','c','d','e','f','g'] # and more...
		end
		
		def power_outputs
			outputs = []
			outputs << out_a if @out_a
			outputs << out_b if @out_b
			outputs << out_c if @out_c
			outputs << out_d if @out_d
			outputs << out_e if @out_e
		end
		
		def dimm_outputs
			[out_f] # and more...
		end
		
		def ttl_outputs
			[out_g] # and more...
		end
	end
end
