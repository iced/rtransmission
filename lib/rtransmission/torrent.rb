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
