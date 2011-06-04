# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Priority < RTransmission::Type
      MAP = {-1 => :low, 0 => :normal, 1 => :high}

      def self.unmap(value)
        MAP[value]
      end

      def self.map(value)
        MAP.key(value)
      end
    end
  end
end
