# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class Percent
      def self.unmap(value)
        value
      end

      def self.map(value)
        value
      end
    end
  end
end
