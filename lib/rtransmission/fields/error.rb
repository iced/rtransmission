module RTransmission
  module Fields
    class Error
      def self.unmap(value)
        [:ok, :tracker_warning, :tracker_error, :local_error][value]
      end
    end
  end
end
