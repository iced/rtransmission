# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class TrackerState < RTransmission::Type
      MAP = {0 => :inactive, 1 => :waiting, 2 => :queued, 3 => :active}

      def self.unmap(value)
        MAP[value]
      end
    end
  end
end
