# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class FileStat < RTransmission::Type
      attribute :bytes_completed, 'bytesCompleted'
      attribute :wanted?, 'wanted'
      attribute :priority, 'priority', :type => RTransmission::Types::Priority

      def self.unmap(value)
        RTransmission::Types::FileStat.new(value)
      end
    end
  end
end
