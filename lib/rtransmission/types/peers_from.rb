# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class PeersFrom < RTransmission::Type
      attribute :cache, 'fromCache'
      attribute :dht, 'fromDht'
      attribute :incoming, 'fromIncoming'
      attribute :ltep, 'fromLtep'
      attribute :pex, 'fromPex'
      attribute :tracker, 'fromTracker'

      def self.unmap(value)
        RTransmission::Types::PeersFrom.new(value)
      end
    end
  end
end
