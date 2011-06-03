# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class PeersFrom < RTransmission::Field
      define_attribute :cache, 'fromCache'
      define_attribute :dht, 'fromDht'
      define_attribute :incoming, 'fromIncoming'
      define_attribute :ltep, 'fromLtep'
      define_attribute :pex, 'fromPex'
      define_attribute :tracker, 'fromTracker'

      def self.unmap(value)
        RTransmission::Fields::PeersFrom.new(value)
      end
    end
  end
end
