module RTransmission
  module Fields
    class SeedIdleMode
      def self.unmap(value)
        [:global, :signle, :unlimited][value]
      end
    end
  end
end
