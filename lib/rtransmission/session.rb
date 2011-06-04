# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  class Session
    attr_reader :client

    def self.attribute(name, rpc_name, args = {})
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

    attribute :alt_speed_down, 'alt-speed-down', :writeable => true
    attribute :alt_speed_enabled?, 'alt-speed-enabled', :writeable => true
    attribute :alt_speed_time_begin, 'alt-speed-time-begin', :writeable => true
    attribute :alt_speed_time_enabled?, 'alt-speed-time-enabled', :writeable => true
    attribute :alt_speed_time_end, 'alt-speed-time-end', :writeable => true
    attribute :alt_speed_time_day, 'alt-speed-time-day', :type => RTransmission::Types::Day, :writeable => true
    attribute :alt_speed_up, 'alt-speed-up', :writeable => true
    attribute :blocklist_url, 'blocklist-url', :writeable => true
    attribute :blocklist_enabled?, 'blocklist-enabled', :writeable => true
    attribute :blocklist_size, 'blocklist-size'
    attribute :cache_size_mb, 'cache-size-mb', :writeable => true
    attribute :config_dir, 'config-dir'
    attribute :download_dir, 'download-dir', :writeable => true
    attribute :download_dir_free_space, 'download-dir-free-space'
    attribute :dht_enabled?, 'dht-enabled', :writeable => true
    attribute :encryption, 'encryption', :type => RTransmission::Types::Encryption, :writeable => true
    attribute :idle_seeding_limit, 'idle-seeding-limit', :writeable => true
    attribute :idle_seeding_limit_enabled?, 'idle-seeding-limit-enabled', :writeable => true
    attribute :incomplete_dir, 'incomplete-dir', :writeable => true
    attribute :incomplete_dir_enabled?, 'incomplete-dir-enabled', :writeable => true
    attribute :lpd_enabled?, 'lpd-enabled', :writeable => true
    attribute :peer_limit_global, 'peer-limit-global', :writeable => true
    attribute :peer_limit_per_torrent, 'peer-limit-per-torrent', :writeable => true
    attribute :pex_enabled?, 'pex-enabled', :writeable => true
    attribute :peer_port, 'peer-port', :writeable => true
    attribute :peer_port_random_on_start?, 'peer-port-random-on-start', :writeable => true
    attribute :port_forwarding_enabled?, 'port-forwarding-enabled', :writeable => true
    attribute :rename_partial_files?, 'rename-partial-files', :writeable => true
    attribute :rpc_version, 'rpc-version'
    attribute :rpc_version_minimum, 'rpc-version-minimum'
    attribute :script_torrent_done_filename, 'script-torrent-done-filename', :writeable => true
    attribute :script_torrent_done_enabled?, 'script-torrent-done-enabled', :writeable => true
    attribute :seed_ratio_limit, 'seedRatioLimit', :type => RTransmission::Types::Percent, :writeable => true
    attribute :seed_ratio_limited?, 'seedRatioLimited', :writeable => true
    attribute :speed_limit_down, 'speed-limit-down', :writeable => true
    attribute :speed_limit_down_enabled?, 'speed-limit-down-enabled', :writeable => true
    attribute :speed_limit_up, 'speed-limit-up', :writeable => true
    attribute :speed_limit_up_enabled?, 'speed-limit-up-enabled', :writeable => true
    attribute :start_added_torrents?, 'start-added-torrents', :writeable => true
    attribute :trash_original_torrent_files?, 'trash-original-torrent-files', :writeable => true
    attribute :units, 'units' # FIXME: add type and writeable
    attribute :utp_enabled?, 'utp-enabled', :writeable => true
    attribute :version, 'version'

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
