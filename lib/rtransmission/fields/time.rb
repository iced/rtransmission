module RTransmission
  module Fields
    class Time
      def self.unmap(value)
        value == 0 ? nil : ::Time.at(value)
      end
    end
  end
end
