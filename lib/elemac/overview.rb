require "elemac/property"
require "elemac/converter"

module Elemac
	class Overview
		PROP_CURRENT_HOUR 		= 62
		PROP_CURRENT_MINUTE 	= 63
		PROP_CURRENT_SECOND 	= 64
		PROP_CURRENT_DAY 		= 371
		PROP_CURRENT_MONTH 		= 370
		PROP_CURRENT_YEAR 		= 369
		PROP_CURRENT_DOW 		= 368
		DAY_NIGHT_FLAG			= 84
		DAY_NIGHT_LIGHT_FLAG	= 86
		DAY_FLAG				= 4
		DAY_LIGHT_FLAG			= 1
		NIGHT_LIGHT_FLAG		= 64	
		OFFSET = 0

		def initialize(device:)
			@device = device
		end
		
		def get_offset
			OFFSET
		end
		
		def current_day
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_DAY, type: :char)
			get_data(prop.to_s).to_i
		end
		
		def current_month
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_MONTH, type: :char)
			get_data(prop.to_s).to_i
		end
		
		def current_year
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_YEAR, type: :char)
			2000 + get_data(prop.to_s).to_i
		end
		
		def current_date
			Converter.format_date(current_year, current_month, current_day)
		end
		
		def current_hour
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_HOUR, type: :char)
			get_data(prop.to_s).to_i
		end
		
		def current_minute
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_MINUTE, type: :char)
			get_data(prop.to_s).to_i
		end
		
		def current_second
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_SECOND, type: :char)
			get_data(prop.to_s).to_i
		end
		
		def current_time
			Converter.format_time(current_hour, current_minute, current_second)
		end
		
		def current_day_of_week
			prop = Property.new(offset: get_offset, address: PROP_CURRENT_DOW, type: :char)
			get_data(prop.to_s)
		end
		
		def day_night_flags
			prop = Property.new(offset: get_offset, address: DAY_NIGHT_FLAG, type: :char)
			get_data(prop.to_s)
		end
		
		def day_night_light_flags
			prop = Property.new(offset: get_offset, address: DAY_NIGHT_LIGHT_FLAG, type: :char)
			get_data(prop.to_s)
		end
		
		def day
			day_night_flags & DAY_FLAG != 0
		end
		
		def night
			!day
		end
		
		def day_light
			day_night_light_flags & DAY_LIGHT_FLAG != 0
		end
		
		def night_light
			day_night_light_flags & NIGHT_LIGHT_FLAG != 0
		end
		
		def inspect
			puts "DATE:\t\t#{current_date}"
			puts "TIME:\t\t#{current_time}"
			puts "DAY OF WEEK:\t#{current_day_of_week}"
			puts "D/N FLG:\t#{day_night_flags} (#{day_night_flags.to_s(2)})"
			puts "D/N LIGHT FLG:\t#{day_night_light_flags} (#{day_night_light_flags.to_s(2)})"
			puts "IS DAY:\t\t#{day}" 
			puts "IS NIGHT:\t#{night}"
			puts "DAY LIGHT:\t#{day_light}"
			puts "NIGHT LIGHT:\t#{night_light}"
		end
		
		private
		def get_data(address)
			@device.request_data(address)
		end
	end
end
