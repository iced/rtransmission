module RTransmission
  module Fields
    class File < RTransmission::Field
      define_attribute :name, 'name'
      define_attribute :length, 'length'
      define_attribute :bytes_completed, 'bytesCompleted'

      def self.unmap(value)
        RTransmission::Fields::File.new(value)
      end
    end
  end
end
