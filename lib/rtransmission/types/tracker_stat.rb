# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

# FIXME: add types where needed
module RTransmission
  module Types
    class TrackerStat < RTransmission::Type
      attribute 'id'
      attribute 'announce'
      attribute 'announceState', :type => :tracker_state
      attribute 'downloadCount'
      attribute 'hasAnnounced', :name => :announced?
      attribute 'hasScraped', :name => :scraped?
      attribute 'host'
      attribute 'isBackup', :name => :backup?
      attribute 'lastAnnouncePeerCount'
      attribute 'lastAnnounceResult'
      attribute 'lastAnnounceStartTime', :type => :time
      attribute 'lastAnnounceSucceeded', :name => :last_announce_succeeded?
      attribute 'lastAnnounceTime', :type => :time
      attribute 'lastAnnounceTimedOut', :name => :last_announce_timed_out?
      attribute 'lastScrapeResult'
      attribute 'lastScrapeStartTime', :type => :time
      attribute 'lastScrapeSucceeded', :name => :last_scrape_succeeded?
      attribute 'lastScrapeTime', :type => :time
      attribute 'lastScrapeTimedOut', :name => :last_scrape_timed_out?
      attribute 'leecherCount'
      attribute 'nextAnnounceTime', :type => :time
      attribute 'nextScrapeTime', :type => :time
      attribute 'scrape'
      attribute 'scrapeState', :type => :tracker_state
      attribute 'seederCount'
      attribute 'tier'

      def self.unmap(value)
        RTransmission::Types::TrackerStat.new(value)
      end
    end
  end
end
