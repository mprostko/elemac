require "elemac/output/default"
require "elemac/converter"

	module Elemac
	class Output::Pwm < Output::Default
		# Reg -> regulated -> PWM
		REG_OFFSET = 1792
		REG_DATA_SIZE = 8
		REG_LEVEL = 1
		REG_MIN_LEVEL = 2
		REG_MAX_LEVEL = 3
		REG_TRANS_TIME = 4
		REG_TRANS_COUNT = 6
		
		def initialize(device:, index: 0, dim_index: 0)
			super(device: device, index: index)
			@dimm_index = dim_index
			@voltage = 12
			@dimmable = true
		end
		
		def get_reg_offset
			throw "Bad offset. Can be only 0..8. #{@index} given." unless (0..8).cover?(@index)
			REG_OFFSET + (@dimm_index * REG_DATA_SIZE)
		end
		
		def level
			prop = Property.new(offset: get_reg_offset, address: REG_LEVEL, type: :char)
			get_data(prop.to_s)
		end
		
		def min_level
			prop = Property.new(offset: get_reg_offset, address: REG_MIN_LEVEL, type: :char)
			get_data(prop.to_s)
		end
		
		def max_level
			prop = Property.new(offset: get_reg_offset, address: REG_MAX_LEVEL, type: :char)
			get_data(prop.to_s)
		end
		
		def trans_time
			prop = Property.new(offset: get_reg_offset, address: REG_TRANS_TIME, type: :short)
			get_data(prop.to_s)
		end
		
		def trans_count
			prop = Property.new(offset: get_reg_offset, address: REG_TRANS_COUNT, type: :char)
			get_data(prop.to_s)
		end
		
		def inspect
			super
			puts "LEVEL:\t\t#{level}"
			puts "MIN LEVEL:\t#{min_level}"
			puts "MAX_LEVEL:\t#{max_level}"
			puts "TRANS TIME:\t#{Converter.seconds_to_hsm(trans_time)}"
			puts "TRANS COUNT:\t#{trans_count}"
		end
	end
end
