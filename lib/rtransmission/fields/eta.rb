module RTransmission
  module Fields
    class ETA
      MAP = {-1 => :not_available, -2 => :unknown}

      def self.unmap(value)
        return value if value >= 0
        MAP[value]
      end
    end
  end
end
