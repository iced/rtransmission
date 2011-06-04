# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class FileStat < RTransmission::Type
      attribute 'bytesCompleted'
      attribute 'wanted', :name => :wanted?
      attribute 'priority', :type => :priority

      def self.unmap(value)
        RTransmission::Types::FileStat.new(value)
      end
    end
  end
end
