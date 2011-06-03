module RTransmission
  module Fields
    class FileStat < RTransmission::Field
      define_attribute :bytes_completed, 'bytesCompleted'
      define_attribute :wanted?, 'wanted'
      define_attribute :priority, 'priority', :type => RTransmission::Fields::Priority

      def self.unmap(value)
        RTransmission::Fields::FileStat.new(value)
      end
    end
  end
end
