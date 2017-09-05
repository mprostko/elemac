module Elemac
	class Property
		def initialize(address:, offset: 0, type: :int)
			@address = address
			@offset = offset
			@type = type
		end
		def get_type(type)
			case(type)
			when :char 	# 1 byte
				'r0'
			when :short # 2 bytes
				'r1'
			when :int 	# 3 bytes
				'r2'
			when :long 	# 4 bytes
				'r3'
			end
		end
		def get_address
			(@offset + @address).to_s(16).upcase.rjust(3, '0')
		end
		def to_s
			"#{get_type(@type)}#{get_address}"
		end
	end
end
