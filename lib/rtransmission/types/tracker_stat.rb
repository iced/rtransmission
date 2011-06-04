# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

# FIXME: add types where needed
module RTransmission
  module Types
    class TrackerStat < RTransmission::Type
      attribute :id, 'id'
      attribute :announce, 'announce'
      attribute :announce_state, 'announceState'
      attribute :download_count, 'downloadCount'
      attribute :has_announced, 'hasAnnounced'
      attribute :has_scraped, 'hasScraped'
      attribute :host, 'host'
      attribute :is_backup, 'isBackup'
      attribute :last_announce_peer_count, 'lastAnnouncePeerCount'
      attribute :last_announce_result, 'lastAnnounceResult'
      attribute :last_announce_start_time, 'lastAnnounceStartTime'
      attribute :last_announce_succeeded, 'lastAnnounceSucceeded'
      attribute :last_announce_time, 'lastAnnounceTime'
      attribute :last_announce_timed_out, 'lastAnnounceTimedOut'
      attribute :last_scrape_result, 'lastScrapeResult'
      attribute :last_scrape_start_time, 'lastScrapeStartTime'
      attribute :last_scrape_succeeded, 'lastScrapeSucceeded'
      attribute :last_scrape_time, 'lastScrapeTime'
      attribute :last_scrape_timed_out, 'lastScrapeTimedOut'
      attribute :leecher_count, 'leecherCount'
      attribute :next_announce_time, 'nextAnnounceTime'
      attribute :next_scrape_time, 'nextScrapeTime'
      attribute :scrape, 'scrape'
      attribute :scrape_state, 'scrapeState'
      attribute :seeder_count, 'seederCount'
      attribute :tier, 'tier'

      def self.unmap(value)
        RTransmission::Types::TrackerStat.new(value)
      end
    end
  end
end
