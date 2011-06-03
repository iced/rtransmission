module RTransmission
  module Fields
    class Priority
      def self.unmap(value)
        {-1 => :low, 0 => :normal, 1 => :high}[value]
      end
    end
  end
end
