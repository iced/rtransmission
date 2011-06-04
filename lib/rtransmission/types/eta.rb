# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class ETA < RTransmission::Type
      MAP = {-1 => :not_available, -2 => :unknown}

      def self.unmap(value)
        return value if value >= 0
        MAP[value]
      end
    end
  end
end
