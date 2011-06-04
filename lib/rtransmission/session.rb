# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  class Session
    attr_reader :client

    def self.attribute(rpc_name, args = {})
      name = args[:name] || RTransmission::Client.rpc_name_to_ruby_name(rpc_name)

      self.send :define_method, name.to_s do
        request = RTransmission::Request.new('session-get', {}, 'Session.' + name.to_s) do |arguments|
          value = arguments[rpc_name]
          RTransmission::Type.unmap(value, args[:type])
        end

        @client.call(request)
      end

      if args[:writeable] == true
        self.send :define_method, name.to_s.gsub('?', '') + '=' do |value|
          rpc_value = RTransmission::Type.unmap(value, args[:type])
          request = RTransmission::Request.new('session-set', {rpc_name => rpc_value}, 'Session.' + name.to_s + '=') do
            value
          end

          @client.call(request)
        end
      end
    end

    attribute 'alt-speed-down', :writeable => true
    attribute 'alt-speed-enabled', :name => :alt_speed_enabled?, :writeable => true
    attribute 'alt-speed-time-begin', :writeable => true
    attribute 'alt-speed-time-enabled', :name => :alt_speed_time_enabled?, :writeable => true
    attribute 'alt-speed-time-end', :writeable => true
    attribute 'alt-speed-time-day', :type => :day, :writeable => true
    attribute 'alt-speed-up', :writeable => true
    attribute 'blocklist-url', :writeable => true
    attribute 'blocklist-enabled', :name => :blocklist_enabled?, :writeable => true
    attribute 'blocklist-size'
    attribute 'cache-size-mb', :writeable => true
    attribute 'config-dir'
    attribute 'download-dir', :writeable => true
    attribute 'download-dir-free-space'
    attribute 'dht-enabled', :name => :dht_enabled?, :writeable => true
    attribute 'encryption', :type => :encryption, :writeable => true
    attribute 'idle-seeding-limit', :writeable => true
    attribute 'idle-seeding-limit-enabled', :name => :idle_seeding_limit_enabled?, :writeable => true
    attribute 'incomplete-dir', :writeable => true
    attribute 'incomplete-dir-enabled', :name => :incomplete_dir_enabled?, :writeable => true
    attribute 'lpd-enabled', :name => :lpd_enabled?, :writeable => true
    attribute 'peer-limit-global', :writeable => true
    attribute 'peer-limit-per-torrent', :writeable => true
    attribute 'pex-enabled', :name => :pex_enabled?, :writeable => true
    attribute 'peer-port', :writeable => true
    attribute 'peer-port-random-on-start', :name => :peer_port_random_on_start?, :writeable => true
    attribute 'port-forwarding-enabled', :name => :port_forwarding_enabled?, :writeable => true
    attribute 'rename-partial-files', :name => :rename_partial_files?, :writeable => true
    attribute 'rpc-version'
    attribute 'rpc-version-minimum'
    attribute 'script-torrent-done-filename', :writeable => true
    attribute 'script-torrent-done-enabled', :name => :script_torrent_done_enabled?, :writeable => true
    attribute 'seedRatioLimit', :writeable => true
    attribute 'seedRatioLimited', :name => :seed_ratio_limited?, :writeable => true
    attribute 'speed-limit-down', :writeable => true
    attribute 'speed-limit-down-enabled', :name => :speed_limit_down_enabled?, :writeable => true
    attribute 'speed-limit-up', :writeable => true
    attribute 'speed-limit-up-enabled', :name => :speed_limit_up_enabled?, :writeable => true
    attribute 'start-added-torrents', :name => :start_added_torrents?, :writeable => true
    attribute 'trash-original-torrent-files', :name => :trash_original_torrent_files?, :writeable => true
    attribute 'units' # FIXME: add type and writeable
    attribute 'utp-enabled', :name => :utp_enabled?, :writeable => true
    attribute 'version'

    def initialize(client)
      @client = client
    end

    def stats
      request = RTransmission::Request.new('session-stats', {}, 'Session.stats') do |arguments|
        RTransmission::Types::Stats.unmap(arguments)
      end

      @client.call(request)
    end

    def blocklist_update
      request = RTransmission::Request.new('blocklist-update', {}, 'Session.blocklist_update') do |arguments|
        arguments['blocklist-size']
      end

      @client.call(request)
    end

    def port_test
      request = RTransmission::Request.new('port-test', {}, 'Session.port_test') do |arguments|
        arguments['port-is-open']
      end

      @client.call(request)
    end

    def shutdown
      @client.call(RTransmission::Request.new('session-close', {}, 'Session.shutdown'))
    end
  end
end
