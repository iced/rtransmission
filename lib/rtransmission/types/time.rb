# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Time < RTransmission::Type
      def self.unmap(value)
        value == 0 ? nil : ::Time.at(value)
      end
    end
  end
end
