module RTransmission
  module Fields
    class SeedIdleMode
      MAP = {0 => :global, 1 => :single, 2 => :unlimited}

      def self.unmap(value)
        MAP[value]
      end

      def self.map(value)
        MAP.key(value)
      end
    end
  end
end
