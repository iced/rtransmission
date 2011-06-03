# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class File < RTransmission::Field
      define_attribute :name, 'name'
      define_attribute :length, 'length'
      define_attribute :bytes_completed, 'bytesCompleted'

      def self.unmap(value)
        RTransmission::Fields::File.new(value)
      end
    end
  end
end
