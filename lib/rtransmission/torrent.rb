# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'base64'

module RTransmission
  class Torrent
    attr_accessor :id

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
      pargs['bandwithPriority'] = args[:bandwith_priority] if args[:bandwith_priority]

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

    def self.define_field(name, rpc_name)
      RTransmission::Torrent.send :define_method, name.to_s do
        request = RTransmission::Request.new('torrent-get', {'fields' => [rpc_name]}, 'Torrent.' + name.to_s) do |arguments|
          result = arguments['torrents'][0][rpc_name]
        end

        @client.call(request)
      end
    end

    define_field :activity_date, 'activityDate'
    define_field :added_date, 'addedDate'
    define_field :bandwidth_priority, 'bandwidthPriority'
    define_field :comment, 'comment'
    define_field :corrupt_ever, 'corruptEver'
    define_field :creator, 'creator'
    define_field :date_created, 'dateCreated'
    define_field :desired_available, 'desiredAvailable'
    define_field :done_date, 'doneDate'
    define_field :download_dir, 'downloadDir'
    define_field :downloaded_ever, 'downloadedEver'
    define_field :download_limit, 'downloadLimit'
    define_field :download_limited, 'downloadLimited'
    define_field :error, 'error'
    define_field :error_string, 'errorString'
    define_field :eta, 'eta'
    define_field :files, 'files'
    define_field :file_stats, 'fileStats'
    define_field :hash_string, 'hashString'
    define_field :have_unchecked, 'haveUnchecked'
    define_field :have_valid, 'haveValid'
    define_field :honors_session_limits, 'honorsSessionLimits'
    define_field :is_finished, 'isFinished'
    define_field :is_private, 'isPrivate'
    define_field :left_until_done, 'leftUntilDone'
    define_field :magnet_link, 'magnetLink'
    define_field :manual_announce_time, 'manualAnnounceTime'
    define_field :max_connected_peers, 'maxConnectedPeers'
    define_field :metadata_percent_complete, 'metadataPercentComplete'
    define_field :name, 'name'
    define_field :peer_limit, 'peer-limit'
    define_field :peers, 'peers'
    define_field :peers_connected, 'peersConnected'
    define_field :peers_from, 'peersFrom'
    define_field :peers_getting_from_us, 'peersGettingFromUs'
    define_field :peers_sending_to_us, 'peersSendingToUs'
    define_field :percent_done, 'percentDone'
    define_field :pieces, 'pieces'
    define_field :piece_count, 'pieceCount'
    define_field :piece_size, 'pieceSize'
    define_field :priorities, 'priorities'
    define_field :rate_download, 'rateDownload'
    define_field :rate_upload, 'rateUpload'
    define_field :recheck_progress, 'recheckProgress'
    define_field :seconds_downloading, 'secondsDownloading'
    define_field :seconds_seeding, 'secondsSeeding'
    define_field :seed_idle_limit, 'seedIdleLimit'
    define_field :seed_idle_mode, 'seedIdleMode'
    define_field :seed_ratio_limit, 'seedRatioLimit'
    define_field :seed_ratio_mode, 'seedRatioMode'
    define_field :size_when_done, 'sizeWhenDone'
    define_field :start_date, 'startDate'
    define_field :status, 'status'
    define_field :trackers, 'trackers'
    define_field :tracker_stats, 'trackerStats'
    define_field :total_size, 'totalSize'
    define_field :torrent_file, 'torrentFile'
    define_field :uploaded_ever, 'uploadedEver'
    define_field :upload_limit, 'uploadLimit'
    define_field :upload_limited, 'uploadLimited'
    define_field :upload_ratio, 'uploadRatio'
    define_field :wanted, 'wanted'
    define_field :webseeds, 'webseeds'
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
