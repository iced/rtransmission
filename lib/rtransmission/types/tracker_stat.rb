# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

# FIXME: add types where needed
module RTransmission
  module Types
    class TrackerStat < RTransmission::Type
      attribute 'id'
      attribute 'announce'
      attribute 'announceState'
      attribute 'downloadCount'
      attribute 'hasAnnounced'
      attribute 'hasScraped'
      attribute 'host'
      attribute 'isBackup'
      attribute 'lastAnnouncePeerCount'
      attribute 'lastAnnounceResult'
      attribute 'lastAnnounceStartTime'
      attribute 'lastAnnounceSucceeded'
      attribute 'lastAnnounceTime'
      attribute 'lastAnnounceTimedOut'
      attribute 'lastScrapeResult'
      attribute 'lastScrapeStartTime'
      attribute 'lastScrapeSucceeded'
      attribute 'lastScrapeTime'
      attribute 'lastScrapeTimedOut'
      attribute 'leecherCount'
      attribute 'nextAnnounceTime'
      attribute 'nextScrapeTime'
      attribute 'scrape'
      attribute 'scrapeState'
      attribute 'seederCount'
      attribute 'tier'

      def self.unmap(value)
        RTransmission::Types::TrackerStat.new(value)
      end
    end
  end
end
