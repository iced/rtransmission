module RTransmission
  class Field
    def self.unmap(value)
      value
    end

    def self.define_attribute(name, rpc_name, args = {})
      self.send :define_method, name.to_s do
        value = @hash[rpc_name]
        value = args[:type].unmap(value) if args[:type]

        value
      end
    end

    def initialize(hash)
      @hash = hash
    end
  end
end
