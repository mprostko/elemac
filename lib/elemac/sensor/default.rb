require "elemac/property"

module Elemac
	module Sensor
		class Default
			FLAGS			= 0
			MEASURMENT 		= 2
			HYSTERESIS		= 10
			DAY_HIGH		= 6
			NIGHT_HIGH		= 8
			DAY_LOW			= 13
			NIGHT_LOW		= 11
			ALARM_HIGH		= 4
			ALARM_LOW		= 15
			DATA_SIZE		= 17	
			FLAG_PRESENT 	= 1
			FLAG_RISE		= 2
			FLAG_LOWER 		= 4
			FLAG_ALARM_HIGH	= 8
			FLAG_ALARM_LOW	= 16
			OFFSET 			= 1864
			
			def initialize(device:, index: 0, divider: 1.0)
				throw 'Index has to be in range 0-5' if !(0..5).cover?(index)
				@device = device
				@index = index
				@offset = get_offset
				@divider = divider
			end
			def get_offset
				# this does not include rh sensor yet
				throw "Bad offset. Can be only 0,1,2,3 for TEMP or 4,5 for PH. #{@index} given." unless (0..5).cover?(@index)
				OFFSET + (@index * DATA_SIZE)
			end
			def value
				prop = Property.new(offset: get_offset, address: MEASURMENT, type: :short)
				get_data(prop.to_s) / @divider
			end
			def hysteresis
				prop = Property.new(offset: get_offset, address: HYSTERESIS, type: :char)
				get_data(prop.to_s) / @divider
			end
			def day_high
				prop = Property.new(offset: get_offset, address: DAY_HIGH, type: :short)
				get_data(prop.to_s) / @divider
			end
			def day_low
				prop = Property.new(offset: get_offset, address: DAY_LOW, type: :short)
				get_data(prop.to_s) / @divider
			end
			def night_high
				prop = Property.new(offset: get_offset, address: NIGHT_HIGH, type: :short)
				get_data(prop.to_s) / @divider
			end
			def night_low
				prop = Property.new(offset: get_offset, address: NIGHT_LOW, type: :short)
				get_data(prop.to_s) / @divider
			end
			def alarm_high
				prop = Property.new(offset: get_offset, address: ALARM_HIGH, type: :short)
				get_data(prop.to_s) / @divider
			end
			def alarm_low
				prop = Property.new(offset: get_offset, address: ALARM_LOW, type: :short)
				get_data(prop.to_s) / @divider
			end
			def flags
				prop = Property.new(offset: get_offset, address: FLAGS, type: :short)
				get_data(prop.to_s)
			end
			def flag_present
				flags & FLAG_PRESENT != 0
			end
			def flag_rise
				return false unless flag_present
				flags & FLAG_RISE != 0
			end
			def flag_lower
				return false unless flag_present
				flags & FLAG_LOWER != 0
			end
			def flag_alarm_high
				return false unless flag_present
				flags & FLAG_ALARM_HIGH != 0
			end
			def flag_alarm_low
				return false unless flag_present
				flags & FLAG_ALARM_LOW != 0
			end
			
			def inspect
				puts "MEASURMENT\t#{value}"
				puts "HYSTERESIS\t#{hysteresis}"
				puts "DAY LOW\t\t#{day_low}"
				puts "DAY HIGH\t#{day_high}"
				puts "NIGHT LOW\t#{night_low}"
				puts "NIGHT HIGH\t#{night_high}"
				puts "ALARM LOW\t#{alarm_low}"
				puts "ALARM HIGH\t#{alarm_high}"
				puts "FLAGS:\t\t#{flags} (#{flags.to_s(2)})"
				puts "F_PRESENT:\t#{flag_present}"
				puts "F_RISE:\t\t#{flag_rise}"
				puts "F_LOWER:\t#{flag_lower}"
				puts "F_ALARM_H:\t#{flag_alarm_high}"
				puts "F_ALARM_L:\t#{flag_alarm_low}"
			end
			
			private
			def get_data(address)
				@device.request_data(address)
			end
		end
	end
end
