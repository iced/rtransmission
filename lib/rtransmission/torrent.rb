# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'base64'

# FIXME: files-wanted/unwanted & prioriry-high/low/normal for both add and new torrents
# FIXME: add/remove/replace trackers
# FIXME: location set support
module RTransmission
  class Torrent
    attr_reader :id

    def self.add(session, args = {})
      pargs = {}

      raise RTransmission::Exception.new('Torrent#add: only one of remote_file, url, or torrent must be specified') if (args.keys & [:remote_file, :url, :torrent]).count != 1
      pargs['filename'] = args[:remote_file] if args[:remote_file]
      pargs['filename'] = args[:url] if args[:url]
      pargs['metainfo'] = Base64::encode(args[:torrent]) if args[:torrent]

      pargs['cookies'] = args[:cookies] if args[:cookies]
      pargs['download-dir'] = args[:download_dir] if args[:download_dir]
      pargs['paused'] = args[:paused] if args[:paused]
      pargs['peer-limit'] = args[:peer_limit] if args[:peer_limit]
      pargs['bandwidthPriority'] = RTransmission::Fields::Priority.map(args[:bandwidth_priority]) if args[:bandwidth_priority]

      request = RTransmission::Request.new('torrent-add', pargs, 'Torrent#add') do |arguments|
        RTransmission::Torrent.new(session, arguments['torrent-added']['id'])
      end

      session.client.call(request)
    end

    def self.list(session)
      request = RTransmission::Request.new('torrent-get', {'fields' => ['id']}, 'Torrent#list') do |arguments|
        torrents = []
        arguments['torrents'].each do |torrent|
          torrents << RTransmission::Torrent.new(session, torrent['id'])
        end

        torrents
      end

      session.client.call(request)
    end

    def self.attribute(name, rpc_name, args = {})
      self.send :define_method, name.to_s do
        request = RTransmission::Request.new('torrent-get', {'ids' => @id, 'fields' => [rpc_name]}, 'Torrent.' + name.to_s) do |arguments|
          value = arguments['torrents'][0][rpc_name]
          RTransmission::Type.unmap(value, args[:type])
        end

        @session.client.call(request)
      end

      if args[:writeable] == true
        self.send :define_method, name.to_s.gsub('?', '') + '=' do |value|
          rpc_value = RTransmission::Type.map(value, args[:type])
          request = RTransmission::Request.new('torrent-set', {'ids' => @id, rpc_name => rpc_value}, 'Torrent.' + name.to_s + '=') do
            value
          end

          @session.client.call(request)
        end
      end
    end

    attribute :activity_date, 'activityDate', :type => :time
    attribute :added_date, 'addedDate', :type => :time
    attribute :bandwidth_priority, 'bandwidthPriority', :type => :priority, :writeable => true
    attribute :comment, 'comment'
    attribute :corrupt_ever, 'corruptEver'
    attribute :creator, 'creator'
    attribute :date_created, 'dateCreated', :type => :time
    attribute :desired_available, 'desiredAvailable'
    attribute :done_date, 'doneDate', :type => :time
    attribute :download_dir, 'downloadDir'
    attribute :downloaded_ever, 'downloadedEver'
    attribute :download_limit, 'downloadLimit', :writeable => true
    attribute :download_limited?, 'downloadLimited', :writeable => true
    attribute :error, 'error', :type => :error
    attribute :error_string, 'errorString'
    attribute :eta, 'eta', :type => :eta
    attribute :files, 'files', :type => [:file]
    attribute :file_stats, 'fileStats', :type => [:file_stat]
    attribute :hash_string, 'hashString'
    attribute :have_unchecked, 'haveUnchecked'
    attribute :have_valid, 'haveValid'
    attribute :honors_session_limits?, 'honorsSessionLimits', :writeable => true
    attribute :finished?, 'isFinished'
    attribute :private?, 'isPrivate'
    attribute :left_until_done, 'leftUntilDone'
    attribute :magnet_link, 'magnetLink'
    attribute :manual_announce_time, 'manualAnnounceTime' # FIXME: add type
    attribute :max_connected_peers, 'maxConnectedPeers'
    attribute :metadata_percent_complete, 'metadataPercentComplete'
    attribute :name, 'name'
    attribute :peer_limit, 'peer-limit', :writeable => true
    attribute :peers, 'peers', :type => [:peer]
    attribute :peers_connected, 'peersConnected'
    attribute :peers_from, 'peersFrom', :type => :peers_from
    attribute :peers_getting_from_us, 'peersGettingFromUs'
    attribute :peers_sending_to_us, 'peersSendingToUs'
    attribute :percent_done, 'percentDone', :type => :percent
    attribute :pieces, 'pieces', :type => :pieces
    attribute :piece_count, 'pieceCount'
    attribute :piece_size, 'pieceSize'
    attribute :priorities, 'priorities', :type => [:priority]
    attribute :rate_download, 'rateDownload'
    attribute :rate_upload, 'rateUpload'
    attribute :recheck_progress, 'recheckProgress', :type => :percent
    attribute :seconds_downloading, 'secondsDownloading'
    attribute :seconds_seeding, 'secondsSeeding'
    attribute :seed_idle_limit, 'seedIdleLimit', :writeable => true
    attribute :seed_idle_mode, 'seedIdleMode', :type => :seed_idle_mode, :writeable => true
    attribute :seed_ratio_limit, 'seedRatioLimit', :type => :percent, :writeable => true
    attribute :seed_ratio_mode, 'seedRatioMode', :type => :seed_ratio_mode, :writeable => true
    attribute :size_when_done, 'sizeWhenDone'
    attribute :start_date, 'startDate', :type => :time
    attribute :status, 'status', :type => :status
    attribute :trackers, 'trackers', :type => [:tracker]
    attribute :tracker_stats, 'trackerStats', :type => [:tracker_stat]
    attribute :total_size, 'totalSize'
    attribute :torrent_file, 'torrentFile'
    attribute :uploaded_ever, 'uploadedEver'
    attribute :upload_limit, 'uploadLimit', :writeable => true
    attribute :upload_limited?, 'uploadLimited', :writeable => true
    attribute :upload_ratio, 'uploadRatio', :type => :percent
    attribute :wanted, 'wanted'
    attribute :webseeds, 'webseeds' # FIXME: add type
    attribute :webseeds_sending_to_us, 'webseedsSendingToUs'

    def initialize(session, id)
      @session = session
      @id = id
    end

    def start
      @session.client.call(RTransmission::Request.new('torrent-start', {'ids' => @id}, 'Torrent.start'))
    end

    def stop
      @session.client.call(RTransmission::Request.new('torrent-stop', {'ids' => @id}, 'Torrent.stop'))
    end

    def verify
      @session.client.call(RTransmission::Request.new('torrent-verify', {'ids' => @id}, 'Torrent.verify'))
    end

    def reannounce
      @session.client.call(RTransmission::Request.new('torrent-reannounce', {'ids' => @id}, 'Torrent.reannounce'))
    end

    def remove(args = {})
      pargs = {}

      pargs['delete-local-data'] = args[:delete_local_data] if args[:delete_local_data]

      @session.client.call(RTransmission::Request.new('torrent-remove', {'ids' => @id}.merge(pargs), 'Torrent.remove'))
    end

    def move(args = {})
      pargs = {}

      pargs['location'] = args[:location] if args[:location]
      pargs['move'] = args[:move] if args[:move]

      @session.client.call(RTransmission::Request.new('torrent-set-location', {'ids' => @id}.merge(pargs), 'Torrent.move'))
    end
  end
end
