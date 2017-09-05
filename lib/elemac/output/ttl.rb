require "elemac/output/default"

module Elemac
	class Output::Ttl < Output::Default
		def initialize(device:, index: 0)
			super(device: device, index: index)
			@voltage = 3.3
		end
	end
end
