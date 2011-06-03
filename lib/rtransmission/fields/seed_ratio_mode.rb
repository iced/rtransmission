module RTransmission
  module Fields
    class SeedRatioMode
      def self.unmap(value)
        [:global, :signle, :unlimited][value]
      end
    end
  end
end
