# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'base64'

# FIXME: files-wanted/unwanted & prioriry-high/low/normal for new torrents
# FIXME: add/remove/replace trackers
module RTransmission
  class Torrent
    attr_reader :id

    def self.add(session, args = {})
      pargs = {}

      raise RTransmission::Exception.new('Torrent#add: only one of remote_file, url, or torrent must be specified') if (args.keys & [:remote_file, :url, :torrent]).count != 1
      pargs['filename'] = args[:remote_file] if args[:remote_file]
      pargs['filename'] = args[:url] if args[:url]
      pargs['metainfo'] = Base64::encode64(args[:torrent]) if args[:torrent]

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

    def self.attribute(rpc_name, args = {})
      name = args[:name] || RTransmission::Client.rpc_name_to_ruby_name(rpc_name)

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

    attribute 'activityDate', :type => :time
    attribute 'addedDate', :type => :time
    attribute 'bandwidthPriority', :type => :priority, :writeable => true
    attribute 'comment'
    attribute 'corruptEver'
    attribute 'creator'
    attribute 'dateCreated', :type => :time
    attribute 'desiredAvailable'
    attribute 'doneDate', :type => :time
    attribute 'downloadDir'
    attribute 'downloadedEver'
    attribute 'downloadLimit', :writeable => true
    attribute 'downloadLimited', :name => :download_limited?, :writeable => true
    attribute 'error', :type => :error
    attribute 'errorString'
    attribute 'eta', :type => :eta
    attribute 'files', :type => [:file]
    attribute 'fileStats', :name => :files_stats, :type => [:file_stat]
    attribute 'hashString'
    attribute 'haveUnchecked'
    attribute 'haveValid'
    attribute 'honorsSessionLimits', :name => :honors_session_limits?, :writeable => true
    attribute 'isFinished', :name => :finished?
    attribute 'isPrivate', :name => :private?
    attribute 'leftUntilDone'
    attribute 'magnetLink'
    attribute 'manualAnnounceTime' # FIXME: add type
    attribute 'maxConnectedPeers'
    attribute 'metadataPercentComplete'
    attribute 'name'
    attribute 'peer-limit', :writeable => true
    attribute 'peers', :type => [:peer]
    attribute 'peersConnected'
    attribute 'peersFrom', :type => :peers_from
    attribute 'peersGettingFromUs'
    attribute 'peersSendingToUs'
    attribute 'percentDone'
    attribute 'pieceCount'
    attribute 'pieceSize'
    attribute 'priorities', :type => [:priority]
    attribute 'rateDownload'
    attribute 'rateUpload'
    attribute 'recheckProgress'
    attribute 'secondsDownloading'
    attribute 'secondsSeeding'
    attribute 'seedIdleLimit', :writeable => true
    attribute 'seedIdleMode', :type => :seed_mode, :writeable => true
    attribute 'seedRatioLimit', :writeable => true
    attribute 'seedRatioMode', :type => :seed_mode, :writeable => true
    attribute 'sizeWhenDone'
    attribute 'startDate', :type => :time
    attribute 'status', :type => :status
    attribute 'trackers', :type => [:tracker]
    attribute 'trackerStats', :name => :trackers_stats, :type => [:tracker_stat]
    attribute 'totalSize'
    attribute 'torrentFile'
    attribute 'uploadedEver'
    attribute 'uploadLimit', :writeable => true
    attribute 'uploadLimited', :name => :upload_limited?, :writeable => true
    attribute 'uploadRatio'
    attribute 'wanted'
    attribute 'webseeds' # FIXME: add type
    attribute 'webseedsSendingToUs'

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

    def pieces
      request = RTransmission::Request.new('torrent-get', {'ids' => @id, 'fields' => ['pieces']}, 'Torrent.pieces') do |arguments|
        pieces = arguments['torrents'][0]['pieces']
        Base64::decode64(pieces).unpack('B*')[0][0 .. piece_count - 1]
      end

      @session.client.call(request)
    end

    def priorities=(priorities)
      phigh = []
      pnormal = []
      plow = []
      0.upto(priorities.size - 1) do |i|
        phigh << i if priorities[i] == :high
        pnormal << i if priorities[i] == :normal
        plow << i if priorities[i] == :low
      end

      pargs = {}
      pargs.merge!({'priority-high' => phigh}) if phigh.size != 0
      pargs.merge!({'priority-normal' => pnormal}) if pnormal.size != 0
      pargs.merge!({'priority-low' => plow}) if plow.size != 0

      request = RTransmission::Request.new('torrent-set', {'ids' => @id}.merge(pargs), 'Torrent.files_priorities=') do
        priorities
      end

      @session.client.call(request)
    end

    def wanted=(wanted)
      pwanted = []
      punwanted = []
      0.upto(wanted.size - 1) do |i|
        pwanted << i if wanted[i]
        punwanted << i unless wanted[i]
      end

      pargs = {}
      pargs.merge!({'files-wanted' => pwanted}) if pwanted.size != 0
      pargs.merge!({'files-unwanted' => punwanted}) if punwanted.size != 0

      request = RTransmission::Request.new('torrent-set', {'ids' => @id}.merge(pargs), 'Torrent.wanted=') do
        wanted
      end

      @session.client.call(request)
    end
  end
end
