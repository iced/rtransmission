module RTransmission
  module Fields
    class Priority
      MAP = {-1 => :low, 0 => :normal, 1 => :high}

      def self.unmap(value)
        MAP[value]
      end

      def self.map(value)
        MAP.key(value)
      end
    end
  end
end
