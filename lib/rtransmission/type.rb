# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  class Type
    def self.type_to_class(type)
      type = type.to_s
      type = '_' + type
      type.gsub!(/_./) { |x| x[1].upcase }

      RTransmission::Types.const_get(type)
    end

    def self.unmap(value, type)
      if type
        if type.class == Array
          type = RTransmission::Type.type_to_class(type[0])
          value.map! { |v| type.unmap(v) }
        else
          type = RTransmission::Type.type_to_class(type)
          value = type.unmap(value)
        end
      end

      value 
    end

    def self.map(value, type)
      if type
        if type.class == Array
          type = RTransmission::Type.type_to_class(type[0])
          value.map! { |v| type.map(v) }
        else
          type = RTransmission::Type.type_to_class(type)
          value = type.map(value)
        end
      end

      value 
    end

    def self.attribute(rpc_name, args = {})
      name = args[:name] || RTransmission::Client.rpc_name_to_ruby_name(rpc_name)
        
      self.send :define_method, name.to_s do
        RTransmission::Type.unmap(@hash[rpc_name], args[:type])
      end
    end

    def initialize(hash)
      @hash = hash
    end
  end
end
