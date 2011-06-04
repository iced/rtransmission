# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class PeersFrom < RTransmission::Type
      attribute 'fromCache', :name => :cache
      attribute 'fromDht', :name => :dht
      attribute 'fromIncoming', :name => :incoming
      attribute 'fromLtep', :name => :ltep
      attribute 'fromPex', :name => :pex
      attribute 'fromTracker', :name => :tracker

      def self.unmap(value)
        RTransmission::Types::PeersFrom.new(value)
      end
    end
  end
end
