module RTransmission
  module Fields
    class Tracker < RTransmission::Field
      define_attribute :id, 'id'
      define_attribute :announce, 'announce'
      define_attribute :scrape, 'scrape'
      define_attribute :tier, 'tier'

      def self.unmap(value)
        RTransmission::Fields::Tracker.new(value)
      end
    end
  end
end
