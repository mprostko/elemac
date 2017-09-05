require "hidapi"

module Elemac
	class Connection
	  	def initialize(vendor: 0x4d8, product: 0x3f, debug: false)
			@debug = debug
			@dev = HIDAPI::open(vendor, product)
			throw 'Cannot open ELEMAC HID' unless @dev
		end
		
		def request_data(address)
			bytes = Array.new(64, 0)
			length = address.length - 1
			bytes[0..length] = address.bytes 
			# Write command to device
			@dev.write(bytes)
			# Read result. 
			response = read_data # this hex form, transform it to number
			response.hex
		end

		# Reading data is in form 'rXYYY' where X is bit length, YYY is the address in hex
		# Read data ends on byte 0
		def read_data
			raw = @dev.read
			response = ""
			debug_read(raw) if @debug

			raw.each_byte { |x| 
				break if x == 0 
				response += x.chr # Get char (for hex)
			}
			# Reverse bit order
			response = response.scan(/../).reverse.join
			response
		end

=begin
		# Writing to controller is in form 'wXYYY=value' where X is bit length, YYY is the address in hex
		def write_data(address, value=32896)
			throw 'USE ONLY IN EMERGENCY CASES!'
			bytes = Array.new(64, 0)
			address[0] = 'w' # change read to write
			value = value.to_s(16) # convert to hex
			# Reverse bit order
			value = value.scan(/../).reverse.join
			message = "#{address}=#{value}"
			data_size = message.length - 1
			bytes[0..data_size] = message.bytes
			@dev.write(bytes)
			raw = @dev.read
			puts raw
			puts raw.inspect
		end
=end	

		private
		def debug_read(raw)
			dbg = []
			count = 0
			raw.each_byte { |x| 
				count += 1
				dbg << x 
			}
			puts "bits: #{count}"
			puts dbg.inspect
		end
	end
end
