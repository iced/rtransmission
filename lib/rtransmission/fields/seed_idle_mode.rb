# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class SeedIdleMode
      MAP = {0 => :global, 1 => :single, 2 => :unlimited}

      def self.unmap(value)
        MAP[value]
      end

      def self.map(value)
        MAP.key(value)
      end
    end
  end
end
