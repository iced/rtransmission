# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class Day
      MAP = {1 => :sunday, 2 => :monday, 4 => :tuesday, 8 => :wednesday, 16 => :thursday, 32 => :friday, 64 => :saturday}

      def self.unmap(value)
        result = []
        MAP.each do |mask, day|
          result << day if mask & value != 0
        end

        result
      end

      def self.map(value)
        result = 0
        value.each do |day|
          result += MAP.key(day)
        end

        result
      end
    end
  end
end
