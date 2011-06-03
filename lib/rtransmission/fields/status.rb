module RTransmission
  module Fields
    class Status
      MAP = {1 => :check_wait, 2 => :check, 4 => :download, 8 => :seed, 16 => :stopped}

      def self.unmap(value)
        result = []
        MAP.each do |mask, status|
          result << status if mask & value != 0
        end

        result
      end
    end
  end
end
