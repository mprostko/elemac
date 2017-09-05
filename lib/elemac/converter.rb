require 'date'

module Elemac
	class Converter
		BIT32_HIGH_MASK = 4278190080
		BIT32_LOW_MASK = 16711680
		BIT16_HIGH_MASK = 65280
		BIT16_LOW_MASK	= 255
		def self.bit32_high(value)
			(value & BIT16_HIGH_MASK) >> 24
		end
		def self.bit32_low(value)
			(value & BIT32_LOW_MASK) >> 16
		end
		def self.bit16_high(value)
			(value & BIT16_HIGH_MASK) >> 8
		end
		def self.bit16_low(value)
			(value & BIT16_LOW_MASK)
		end	
		def self.int_to_hour(value)
			hour 	= bit16_low(value).to_s
			minute 	= bit16_high(value).to_s
			"#{hour.rjust(2,'0')}:#{minute.rjust(2,'0')}"
		end
		def self.seconds_to_hsm(value)
			value = 14400 if value > 14400
			Time.at(value).utc.strftime("%H:%M:%S")
		end
		def self.long_to_date(value)
			day 	= bit32_low(value).to_s
			month 	= bit16_high(value).to_s
			year	= (2000 + bit16_low(value).to_i).to_s
			"#{year}-#{month.rjust(2,'0')}-#{day.rjust(2,'0')}"
		end
		# calibration date should be in format YYYY-MM-DD
		# reminder is the amount of months that ph has to be calibrated
		def self.ph_reminder(value, calibration_date, reminder=0)
			value = value & 3
			ph7, ph49, out_of_date = false
			case(value)
			when 0
				ph7, ph49, out_of_date = false, false, false
			when 1
				ph7, ph49, out_of_date = true, false, false
			when 2
				ph7, ph49, out_of_date = false, true, false
			when 3
				ph7, ph49 = true, true
				next_calibration_date = Date.parse(calibration_date) << -reminder
				out_of_date = next_calibration_date < Date.today 
			end
			"PH7: #{ph7.to_s}, PH49: #{ph49.to_s}, Calibrated: #{out_of_date.to_s}"
		end
		def self.format_date(year,month,date)
			"#{year.to_s.rjust(2,'0')}-#{month.to_s.rjust(2,'0')}-#{date.to_s.rjust(2,'0')}"
		end
		def self.format_time(hour,minute,second)
			"#{hour.to_s.rjust(2,'0')}:#{minute.to_s.rjust(2,'0')}:#{second.to_s.rjust(2,'0')}"
		end
		def self.ph_9_enabled(value)
			value & 4 > 0
		end
	end
end
