# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Error < RTransmission::Type
      MAP = {0 => :ok, 1 => :tracker_warning, 2 => :tracker_error, 3 => :local_error}

      def self.unmap(value)
        MAP[value]
      end
    end
  end
end
