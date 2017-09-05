require "elemac/property"
require "elemac/converter"

module Elemac
	class Light
		SUNRISE				= 92
		SUNSET				= 94
		DAY_BREAK_START		= 160
		DAY_BREAK_END		= 162	
		NIGHT_BREAK_START	= 164
		NIGHT_BREAK_END		= 166
		DAYLIGHT_SAVE		= 360
		LAMP_POWER_ON_DELAY	= 91
		OFFSET   			= 0
		
		def initialize(device:)
			@device = device
		end
		
		def get_offset
			OFFSET
		end

		def sunrise
			prop = Property.new(offset: get_offset, address: SUNRISE, type: :short)
			Converter.int_to_hour(get_data(prop.to_s))
		end
		
		def sunset
			prop = Property.new(offset: get_offset, address: SUNSET, type: :short)
			Converter.int_to_hour(get_data(prop.to_s))
		end
		
		def day_break_start
			prop = Property.new(offset: get_offset, address: DAY_BREAK_START, type: :short)
			Converter.int_to_hour(get_data(prop.to_s))
		end
		
		def day_break_end
			prop = Property.new(offset: get_offset, address: DAY_BREAK_END, type: :short)
			Converter.int_to_hour(get_data(prop.to_s))
		end
		
		def night_break_start
			prop = Property.new(offset: get_offset, address: NIGHT_BREAK_START, type: :short)
			Converter.int_to_hour(get_data(prop.to_s))
		end
		
		def night_break_end
			prop = Property.new(offset: get_offset, address: NIGHT_BREAK_END, type: :short)
			Converter.int_to_hour(get_data(prop.to_s))
		end
		
		def light_power_on_delay
			prop = Property.new(offset: get_offset, address: LAMP_POWER_ON_DELAY, type: :char)
			get_data(prop.to_s)
		end
		
		def inspect
			puts "SUNRISE:\t#{sunrise}"
			puts "D-BREAK START:\t#{day_break_start}"
			puts "D-BREAK END:\t#{day_break_end}"
			puts "SUNSET:\t\t#{sunset}"
			puts "N-BREAK START:\t#{night_break_start}"
			puts "N-BREAK END:\t#{night_break_end}"
			puts "HQI DELAY:\t#{light_power_on_delay}"
		end
		
		private
		def get_data(address)
			@device.request_data(address)
		end
	end
end
