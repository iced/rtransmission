# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Stats < RTransmission::Type
      attribute 'activeTorrentCount'
      attribute 'downloadSpeed'
      attribute 'pausedTorrentCount'
      attribute 'torrentCount'
      attribute 'uploadSpeed'
      attribute 'cumulative-stats', :type => :traffic_stats
      attribute 'current-stats', :type => :traffic_stats

      def self.unmap(value)
        RTransmission::Types::Stats.new(value)
      end
    end
  end
end
