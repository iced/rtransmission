# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  class Type
    def self.unmap(value, type)
      if type
        if type.class == Array
          type = type[0]
          value.map! { |v| type.unmap(v) }
        else
          value = type.unmap(value)
        end
      end

      value 
    end

    def self.map(value, type)
      if type
        if type.class == Array
          type = type[0]
          value.map! { |v| type.map(v) }
        else
          value = type.map(value)
        end
      end

      value 
    end

    def self.attribute(name, rpc_name, args = {})
      self.send :define_method, name.to_s do
        RTransmission::Type.unmap(@hash[rpc_name], args[:type])
      end
    end

    def initialize(hash)
      @hash = hash
    end
  end
end
