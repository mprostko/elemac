require "elemac/output/default"

module Elemac
	class Output::Power < Output::Default
		def initialize(device:, index: 0)
			super(device: device, index: index)
			@voltage = 230
		end
	end
end
