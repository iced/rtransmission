# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Peer < RTransmission::Type
      attribute 'address'
      attribute 'clientIsChoked', :name => :client_choked?
      attribute 'clientIsInterested', :name => :client_interested?
      attribute 'clientName'
      attribute 'flagStr'
      attribute 'isDownloadingFrom', :name => :downloading_from? 
      attribute 'isEncrypted', :name => :encrypted?
      attribute 'isIncoming', :name => :incoming?
      attribute 'isUTP', :name => :utp?
      attribute 'isUploadingTo', :name => :uploading_to?
      attribute 'peerIsChoked', :name => :peer_choked?
      attribute 'peerIsInterested', :name => :peer_interested?
      attribute 'port'
      attribute 'progress'
      attribute 'rateToClient'
      attribute 'rateToPeer'

      def self.unmap(value)
        RTransmission::Types::Peer.new(value)
      end
    end
  end
end
