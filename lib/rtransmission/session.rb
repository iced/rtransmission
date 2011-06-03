# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  class Session
    def self.define_field(name, rpc_name, args = {})
      self.send :define_method, name.to_s do
        request = RTransmission::Request.new('session-get', {}, 'Session.' + name.to_s) do |arguments|
          result = arguments[rpc_name]
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

          request = RTransmission::Request.new('session-set', {rpc_name => rpc_value}, 'Session.' + name.to_s + '=') do
            value
          end

          @client.call(request)
        end
      end
    end

    define_field :alt_speed_down, 'alt-speed-down', :writeable => true
    define_field :alt_speed_enabled?, 'alt-speed-enabled', :writeable => true
    define_field :alt_speed_time_begin, 'alt-speed-time-begin', :writeable => true
    define_field :alt_speed_time_enabled?, 'alt-speed-time-enabled', :writeable => true
    define_field :alt_speed_time_end, 'alt-speed-time-end', :writeable => true
    define_field :alt_speed_time_day, 'alt-speed-time-day', :type => RTransmission::Fields::Day, :writeable => true
    define_field :alt_speed_up, 'alt-speed-up', :writeable => true
    define_field :blocklist_url, 'blocklist-url', :writeable => true
    define_field :blocklist_enabled?, 'blocklist-enabled', :writeable => true
    define_field :blocklist_size, 'blocklist-size'
    define_field :cache_size_mb, 'cache-size-mb', :writeable => true
    define_field :config_dir, 'config-dir'
    define_field :download_dir, 'download-dir', :writeable => true
    define_field :download_dir_free_space, 'download-dir-free-space'
    define_field :dht_enabled?, 'dht-enabled', :writeable => true
    define_field :encryption, 'encryption', :type => RTransmission::Fields::Encryption, :writeable => true
    define_field :idle_seeding_limit, 'idle-seeding-limit', :writeable => true
    define_field :idle_seeding_limit_enabled?, 'idle-seeding-limit-enabled', :writeable => true
    define_field :incomplete_dir, 'incomplete-dir', :writeable => true
    define_field :incomplete_dir_enabled?, 'incomplete-dir-enabled', :writeable => true
    define_field :lpd_enabled?, 'lpd-enabled', :writeable => true
    define_field :peer_limit_global, 'peer-limit-global', :writeable => true
    define_field :peer_limit_per_torrent, 'peer-limit-per-torrent', :writeable => true
    define_field :pex_enabled?, 'pex-enabled', :writeable => true
    define_field :peer_port, 'peer-port', :writeable => true
    define_field :peer_port_random_on_start?, 'peer-port-random-on-start', :writeable => true
    define_field :port_forwarding_enabled?, 'port-forwarding-enabled', :writeable => true
    define_field :rename_partial_files?, 'rename-partial-files', :writeable => true
    define_field :rpc_version, 'rpc-version'
    define_field :rpc_version_minimum, 'rpc-version-minimum'
    define_field :script_torrent_done_filename, 'script-torrent-done-filename', :writeable => true
    define_field :script_torrent_done_enabled?, 'script-torrent-done-enabled', :writeable => true
    define_field :seed_ratio_limit, 'seedRatioLimit', :type => RTransmission::Fields::Percent, :writeable => true
    define_field :seed_ratio_limited?, 'seedRatioLimited', :writeable => true
    define_field :speed_limit_down, 'speed-limit-down', :writeable => true
    define_field :speed_limit_down_enabled?, 'speed-limit-down-enabled', :writeable => true
    define_field :speed_limit_up, 'speed-limit-up', :writeable => true
    define_field :speed_limit_up_enabled?, 'speed-limit-up-enabled', :writeable => true
    define_field :start_added_torrents?, 'start-added-torrents', :writeable => true
    define_field :trash_original_torrent_files?, 'trash-original-torrent-files', :writeable => true
    define_field :units, 'units' # FIXME: add type and writeable
    define_field :utp_enabled?, 'utp-enabled', :writeable => true
    define_field :version, 'version'

    def initialize(client)
      @client = client
    end
  end
end
