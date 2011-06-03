module RTransmission
  module Fields
    class ETA
      def self.unmap(value)
        return value if value >= 0
        {-1 => :not_available, -2 => :unknown}[value]
      end
    end
  end
end
