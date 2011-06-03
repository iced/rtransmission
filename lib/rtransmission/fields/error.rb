module RTransmission
  module Fields
    class Error
      MAP = {0 => :ok, 1 => :tracker_warning, 2 => :tracker_error, 3 => :local_error}

      def self.unmap(value)
        MAP[value]
      end
    end
  end
end
