# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Tracker < RTransmission::Type
      attribute 'id'
      attribute 'announce'
      attribute 'scrape'
      attribute 'tier'

      def self.unmap(value)
        RTransmission::Types::Tracker.new(value)
      end
    end
  end
end
