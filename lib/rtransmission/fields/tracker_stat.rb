# FIXME: add types where needed
module RTransmission
  module Fields
    class TrackerStat < RTransmission::Field
      define_attribute :id, 'id'
      define_attribute :announce, 'announce'
      define_attribute :announce_state, 'announceState'
      define_attribute :download_count, 'downloadCount'
      define_attribute :has_announced, 'hasAnnounced'
      define_attribute :has_scraped, 'hasScraped'
      define_attribute :host, 'host'
      define_attribute :is_backup, 'isBackup'
      define_attribute :last_announce_peer_count, 'lastAnnouncePeerCount'
      define_attribute :last_announce_result, 'lastAnnounceResult'
      define_attribute :last_announce_start_time, 'lastAnnounceStartTime'
      define_attribute :last_announce_succeeded, 'lastAnnounceSucceeded'
      define_attribute :last_announce_time, 'lastAnnounceTime'
      define_attribute :last_announce_timed_out, 'lastAnnounceTimedOut'
      define_attribute :last_scrape_result, 'lastScrapeResult'
      define_attribute :last_scrape_start_time, 'lastScrapeStartTime'
      define_attribute :last_scrape_succeeded, 'lastScrapeSucceeded'
      define_attribute :last_scrape_time, 'lastScrapeTime'
      define_attribute :last_scrape_timed_out, 'lastScrapeTimedOut'
      define_attribute :leecher_count, 'leecherCount'
      define_attribute :next_announce_time, 'nextAnnounceTime'
      define_attribute :next_scrape_time, 'nextScrapeTime'
      define_attribute :scrape, 'scrape'
      define_attribute :scrape_state, 'scrapeState'
      define_attribute :seeder_count, 'seederCount'
      define_attribute :tier, 'tier'

      def self.unmap(value)
        RTransmission::Fields::TrackerStat.new(value)
      end
    end
  end
end
