# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class Stats < RTransmission::Field
      define_attribute :active_torrent_count, 'activeTorrentCount'
      define_attribute :download_speed, 'downloadSpeed'
      define_attribute :paused_torrent_count, 'pausedTorrentCount'
      define_attribute :torrent_count, 'torrentCount'
      define_attribute :upload_speed, 'uploadSpeed'
      define_attribute :cumulative_stats, 'cumulative-stats', :type => RTransmission::Fields::TrafficStats
      define_attribute :current_stats, 'current-stats', :type => RTransmission::Fields::TrafficStats

      def self.unmap(value)
        RTransmission::Fields::Stats.new(value)
      end
    end
  end
end
