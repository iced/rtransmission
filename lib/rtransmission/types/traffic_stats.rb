# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class TrafficStats < RTransmission::Type
      attribute :uploaded_bytes, 'uploadedBytes'
      attribute :downloaded_bytes, 'downloadedBytes'
      attribute :files_added, 'filesAdded'
      attribute :session_count, 'sessionCount'
      attribute :seconds_active, 'secondsActive'

      def self.unmap(value)
        RTransmission::Types::TrafficStats.new(value)
      end
    end
  end
end
