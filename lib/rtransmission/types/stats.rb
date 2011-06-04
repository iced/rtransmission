# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Stats < RTransmission::Type
      attribute :active_torrent_count, 'activeTorrentCount'
      attribute :download_speed, 'downloadSpeed'
      attribute :paused_torrent_count, 'pausedTorrentCount'
      attribute :torrent_count, 'torrentCount'
      attribute :upload_speed, 'uploadSpeed'
      attribute :cumulative_stats, 'cumulative-stats', :type => RTransmission::Types::TrafficStats
      attribute :current_stats, 'current-stats', :type => RTransmission::Types::TrafficStats

      def self.unmap(value)
        RTransmission::Types::Stats.new(value)
      end
    end
  end
end
