# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Status < RTransmission::Type
      MAP = {1 => :check_wait, 2 => :check, 4 => :download, 8 => :seed, 16 => :stopped}

      def self.unmap(value)
        result = []
        MAP.each do |mask, status|
          result << status if mask & value != 0
        end

        result
      end
    end
  end
end
