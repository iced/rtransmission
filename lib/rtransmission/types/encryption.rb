# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Encryption < RTransmission::Type
      def self.unmap(value)
        value.to_sym
      end

      def self.map(value)
        value.to_s
      end
    end
  end
end
