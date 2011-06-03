# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class TrafficStats < RTransmission::Field
      define_attribute :uploaded_bytes, 'uploadedBytes'
      define_attribute :downloaded_bytes, 'downloadedBytes'
      define_attribute :files_added, 'filesAdded'
      define_attribute :session_count, 'sessionCount'
      define_attribute :seconds_active, 'secondsActive'

      def self.unmap(value)
        RTransmission::Fields::TrafficStats.new(value)
      end
    end
  end
end
