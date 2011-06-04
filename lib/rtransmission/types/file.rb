# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class File < RTransmission::Type
      attribute :name, 'name'
      attribute :length, 'length'
      attribute :bytes_completed, 'bytesCompleted'

      def self.unmap(value)
        RTransmission::Types::File.new(value)
      end
    end
  end
end
