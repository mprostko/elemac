require "elemac/property"

module Elemac
	module Output
		class Default
			OFFSET			= 2048
			DATA_SIZE 		= 1
			TYPE 			= 0
			MODE 			= 256
			DAY_1_START 	= 25
			DAY_1_STOP 		= 281
			DAY_2_START 	= 100
			DAY_2_STOP 		= 356
			DAY_3_START 	= 175
			DAY_3_STOP 		= 431
			WORK 			= 512
			PAUSE 			= 587
			TIMER 			= 662
			POWER_FLAG		= 1
			VOLTAGE_FLAG	= 14 # bits 1110
			DIMMABLE_FLAG 	= 16
			NEGATIVE_FLAG 	= 32
			TIMER_ON_FLAG 	= 64
			PRESENT_FLAG 	= 128
			def initialize(device:, index: 0)
				@device = device
				@index = index
				@voltage = 0
				@dimmable = false
				@dim_value = 0
			end
			
			def get_offset
				throw "Bad offset. Can be only 0..25. #{@index} given." unless (0..25).cover?(@index)
				OFFSET + (@index * DATA_SIZE)
			end
			
			def name
				(@index + 'A'.ord).chr
			end
			
			def type
				prop = Property.new(offset: get_offset, address: TYPE, type: :short)
				get_data(prop.to_s)
			end
			
			def powered
				type & POWER_FLAG != 0
			end
			
			def board_dimmable
				type & DIMMABLE_FLAG != 0
			end
			
			def board_present
				type & 128 != 0
			end
			
			def board_voltage
				val = (type & VOLTAGE_FLAG) >> 1
				case(val)
				when 0
					230
				when 1
					12
				when 2
					5
				when 3
					3
				else
					0
				end
			end
			
			def negative
				type & NEGATIVE_FLAG != 0
			end
			
			def timer_on
				type & TIMER_ON_FLAG != 0
			end
			
			def dimmable
				@dimmable
			end
			
			def inspect
				puts "NAME:\t\t#{name}"
				puts "TYPE:\t\t#{type}"
				puts "POWERED:\t#{powered}"
				puts "TIMER:\t\t#{timer_on}"
				puts "NEGATIVE:\t#{negative}"
				puts "BRD_PRESENT:\t#{board_present}"
				puts "BRD_VOLTAGE:\t#{board_voltage}"
				puts "BRD_DIMMABLE:\t#{board_dimmable}"		
			end
			
			private
			def get_data(address)
				@device.request_data(address)
			end
		end
	end
end
