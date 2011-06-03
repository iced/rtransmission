# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'base64'

# FIXME: files-wanted/unwanted & prioriry-high/low/normal for both add and new torrents
# FIXME: add/remove/replace trackers
module RTransmission
  class Torrent
    attr_reader :id

    def self.add(client, args = {})
      pargs = {}

      raise RTransmission::Exception.new('Torrent#add: only one of remote_file, url, or torrent must be specified') if (args.keys & [:remote_file, :url, :torrent]).count != 1
      pargs['filename'] = args[:remote_file] if args[:remote_file]
      pargs['filename'] = args[:url] if args[:url]
      pargs['metainfo'] = Base64::encode(args[:torrent]) if args[:torrent]

      pargs['cookies'] = args[:cookies] if args[:cookies]
      pargs['download-dir'] = args[:download_dir] if args[:download_dir]
      pargs['paused'] = args[:paused] if args[:paused]
      pargs['peer-limit'] = args[:peer_limit] if args[:peer_limit]
      pargs['bandwithPriority'] = args[:bandwith_priority] if args[:bandwith_priority] # FIXME: use field here

      request = RTransmission::Request.new('torrent-add', pargs, 'Torrent#add') do |arguments|
        RTransmission::Torrent.new(client, arguments['torrent-added']['id'])
      end

      client.call(request)
    end

    def self.list(client)
      request = RTransmission::Request.new('torrent-get', {'fields' => ['id']}, 'Torrent#list') do |arguments|
        torrents = []
        arguments['torrents'].each do |torrent|
          torrents << RTransmission::Torrent.new(client, torrent['id'])
        end

        torrents
      end

      client.call(request)
    end

    def self.define_field(name, rpc_name, args = {})
      self.send :define_method, name.to_s do
        request = RTransmission::Request.new('torrent-get', {'ids' => @id, 'fields' => [rpc_name]}, 'Torrent.' + name.to_s) do |arguments|
          result = arguments['torrents'][0][rpc_name]
          if args[:type]
            type = args[:type]
            if type.class == Array
              type = type[0]
              result.map! { |r| type.unmap(r) }
            else
              result = type.unmap(result)
            end
          end

          result 
        end

        @client.call(request)
      end

      if args[:writeable] == true
        self.send :define_method, name.to_s.gsub('?', '') + '=' do |value|
          rpc_value = value
          if args[:type]
            type = args[:type]
            if type.class == Array
              type = type[0]
              rpc_value.map! { |r| type.map(r) }
            else
              rpc_value = type.map(rpc_value)
            end
          end

          request = RTransmission::Request.new('torrent-set', {'ids' => @id, rpc_name => rpc_value}, 'Torrent.' + name.to_s + '=') do
            value
          end

          @client.call(request)
        end
      end
    end

    define_field :activity_date, 'activityDate', :type => RTransmission::Fields::Time
    define_field :added_date, 'addedDate', :type => RTransmission::Fields::Time
    define_field :bandwidth_priority, 'bandwidthPriority', :type => RTransmission::Fields::Priority, :writeable => true
    define_field :comment, 'comment'
    define_field :corrupt_ever, 'corruptEver'
    define_field :creator, 'creator'
    define_field :date_created, 'dateCreated', :type => RTransmission::Fields::Time
    define_field :desired_available, 'desiredAvailable'
    define_field :done_date, 'doneDate', :type => RTransmission::Fields::Time
    define_field :download_dir, 'downloadDir'
    define_field :downloaded_ever, 'downloadedEver'
    define_field :download_limit, 'downloadLimit', :writeable => true
    define_field :download_limited?, 'downloadLimited', :writeable => true
    define_field :error, 'error', :type => RTransmission::Fields::Error
    define_field :error_string, 'errorString'
    define_field :eta, 'eta', :type => RTransmission::Fields::ETA
    define_field :files, 'files', :type => [RTransmission::Fields::File]
    define_field :file_stats, 'fileStats', :type => [RTransmission::Fields::FileStat]
    define_field :hash_string, 'hashString'
    define_field :have_unchecked, 'haveUnchecked'
    define_field :have_valid, 'haveValid'
    define_field :honors_session_limits?, 'honorsSessionLimits', :writeable => true
    define_field :finished?, 'isFinished'
    define_field :private?, 'isPrivate'
    define_field :left_until_done, 'leftUntilDone'
    define_field :magnet_link, 'magnetLink'
    define_field :manual_announce_time, 'manualAnnounceTime' # FIXME: add type
    define_field :max_connected_peers, 'maxConnectedPeers'
    define_field :metadata_percent_complete, 'metadataPercentComplete'
    define_field :name, 'name'
    define_field :peer_limit, 'peer-limit', :writeable => true
    define_field :peers, 'peers', :type => [RTransmission::Fields::Peer]
    define_field :peers_connected, 'peersConnected'
    define_field :peers_from, 'peersFrom', :type => RTransmission::Fields::PeersFrom
    define_field :peers_getting_from_us, 'peersGettingFromUs'
    define_field :peers_sending_to_us, 'peersSendingToUs'
    define_field :percent_done, 'percentDone', :type => RTransmission::Fields::Percent
    define_field :pieces, 'pieces', :type => RTransmission::Fields::Pieces
    define_field :piece_count, 'pieceCount'
    define_field :piece_size, 'pieceSize'
    define_field :priorities, 'priorities', :type => [RTransmission::Fields::Priority]
    define_field :rate_download, 'rateDownload'
    define_field :rate_upload, 'rateUpload'
    define_field :recheck_progress, 'recheckProgress', :type => RTransmission::Fields::Percent
    define_field :seconds_downloading, 'secondsDownloading'
    define_field :seconds_seeding, 'secondsSeeding'
    define_field :seed_idle_limit, 'seedIdleLimit', :writeable => true
    define_field :seed_idle_mode, 'seedIdleMode', :type => RTransmission::Fields::SeedIdleMode, :writeable => true
    define_field :seed_ratio_limit, 'seedRatioLimit', :type => RTransmission::Fields::Percent, :writeable => true
    define_field :seed_ratio_mode, 'seedRatioMode', :type => RTransmission::Fields::SeedRatioMode, :writeable => true
    define_field :size_when_done, 'sizeWhenDone'
    define_field :start_date, 'startDate', :type => RTransmission::Fields::Time
    define_field :status, 'status', :type => RTransmission::Fields::Status
    define_field :trackers, 'trackers', :type => [RTransmission::Fields::Tracker]
    define_field :tracker_stats, 'trackerStats', :type => [RTransmission::Fields::TrackerStat]
    define_field :total_size, 'totalSize'
    define_field :torrent_file, 'torrentFile'
    define_field :uploaded_ever, 'uploadedEver'
    define_field :upload_limit, 'uploadLimit', :writeable => true
    define_field :upload_limited?, 'uploadLimited', :writeable => true
    define_field :upload_ratio, 'uploadRatio', :type => RTransmission::Fields::Percent
    define_field :wanted, 'wanted'
    define_field :webseeds, 'webseeds' # FIXME: add type
    define_field :webseeds_sending_to_us, 'webseedsSendingToUs'

    def initialize(client, id)
      @client = client
      @id = id
    end

    def start
      @client.call(RTransmission::Request.new('torrent-start', {'ids' => @id}, 'Torrent.start'))
    end

    def stop
      @client.call(RTransmission::Request.new('torrent-stop', {'ids' => @id}, 'Torrent.stop'))
    end

    def verify
      @client.call(RTransmission::Request.new('torrent-verify', {'ids' => @id}, 'Torrent.verify'))
    end

    def reannounce
      @client.call(RTransmission::Request.new('torrent-reannounce', {'ids' => @id}, 'Torrent.reannounce'))
    end

    def remove(args = {})
      pargs = {}

      pargs['delete-local-data'] = args[:delete_local_data] if args[:delete_local_data]

      @client.call(RTransmission::Request.new('torrent-remove', {'ids' => @id}.merge(pargs), 'Torrent.remove'))
    end

    def move(args = {})
      pargs = {}

      pargs['location'] = args[:location] if args[:location]
      pargs['move'] = args[:move] if args[:move]

      @client.call(RTransmission::Request.new('torrent-set-location', {'ids' => @id}.merge(pargs), 'Torrent.move'))
    end
  end
end
