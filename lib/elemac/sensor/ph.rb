require "elemac/sensor/default"
require "elemac/converter"

# Index can be only 0 or 1, defined by Length in PhSettings.cs
# to jest inny index (tylko dla PH) bo odwołujemy się do innego offsetu (ph offset)
# CALIBR_7_OFFSET 	= 8 # not used in elemac
# CALIBR_49_OFFSET 	= 9 # not used in elemac
	module Elemac
	class Sensor::Ph < Sensor::Default
		PH_OFFSET			= 2786
		PH_DATA_SIZE 		= 15
		CALIBR_7 			= 1
		CALIBR_49			= 3
		CALIBR_DATE 		= 5
		CALIBR_FLAGS 		= 0		# zwraca random, czasem 0,24,16 - brane sa 3 pierwsze bity pod uwage
		SLOPE 				= 10
		ELZERO 				= 12
		REMINDER 			= 14
		ADC_OFFSET			= 0
		ADC1				= 228
		ADC2				= 1540
		
		# -4 poniewaz index sensora jest 4 lub 5 dla ph, a dane offsetowe do kalibracji moga
		# przyjmowac index 0 lub 1 wyłącznie co odpowiada indeksowi 0 lub 1 w zaleznosci od czujnika
		def get_ph_offset
			index = (@index - 4)
			throw "Bad offset. Can be only 0 or 1. #{index} given." unless (0..1).cover?(index)
			PH_OFFSET + (index * PH_DATA_SIZE)
		end
		
		def calibr_7
			prop = Property.new(offset: get_ph_offset, address: CALIBR_7, type: :short)
			get_data(prop.to_s)
		end
		
		# TODO: chyba nie sprowadza dobrych wartosci dla ph9 (218) - wyswietla tyle co w 4
		def calibr_49
			prop = Property.new(offset: get_ph_offset, address: CALIBR_49, type: :short)
			get_data(prop.to_s)
		end
		
		def calibr_flags
			prop = Property.new(offset: get_ph_offset, address: CALIBR_FLAGS, type: :char)
			get_data(prop.to_s)
		end
		
		def calibr_date
			prop = Property.new(offset: get_ph_offset, address: CALIBR_DATE, type: :int)
			Converter.long_to_date(get_data(prop.to_s))
		end
		
		# a warning should be shown when this value is > 22240
		def slope
			prop = Property.new(offset: get_ph_offset, address: SLOPE, type: :short)
			get_data(prop.to_s)
		end
		
		def slope_mv_ph
			current_slope = slope
			if current_slope == 0
				0
			else
				1638400.0 / current_slope * (625.0 / 128.0) / 11.9090900421143
			end
		end
		
		def elzero
			prop = Property.new(offset: get_ph_offset, address: ELZERO, type: :short)
			get_data(prop.to_s)
		end
		
		def reminder
			prop = Property.new(offset: get_ph_offset, address: REMINDER, type: :char)
			get_data(prop.to_s)
		end
		
		def calibr_status
			Converter.ph_reminder(calibr_flags, calibr_date, reminder)
		end
		
		def ph_9_enabled
			Converter.ph_9_enabled(calibr_flags)
		end
		
		def adc
			# depending on current ph 0 or 1, get adc value
			adc_address = (@index - 4) == 0 ? ADC1 : ADC2
			prop = Property.new(offset: ADC_OFFSET, address: ADC1, type: :short)
			get_data(prop.to_s)
		end
		
		def inspect
			super
			puts "ADC\t\t#{adc}"
			puts "CALIBR 7\t#{calibr_7}"
			puts "CALIBR 49\t#{calibr_49}"
			puts "PH9 ENABLED\t#{ph_9_enabled}"
			puts "CALIBR_FLAGS\t#{calibr_flags} (#{(calibr_flags & 7).to_s(2)})"
			puts "CALIBR_DATE\t#{calibr_date}"
			puts "SLOPE\t\t#{slope}"
			puts "SLOPE mV/pH\t#{slope_mv_ph}"
			puts "ELZERO\t\t#{elzero}"
			puts "REMINDER\t#{reminder}"
			puts "STATUS\t\t#{calibr_status}"
		end
	end
end
