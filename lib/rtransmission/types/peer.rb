# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Types
    class Peer < RTransmission::Type
      attribute :address, 'address'
      attribute :client_choked?, 'clientIsChoked'
      attribute :client_interested?, 'clientIsInterested'
      attribute :client_name, 'clientName'
      attribute :flag_str, 'flagStr'
      attribute :downloading_from?, 'isDownloadingFrom'
      attribute :encrypted?, 'isEncrypted'
      attribute :incoming?, 'isIncoming'
      attribute :utp?, 'isUTP'
      attribute :uploading_to?, 'isUploadingTo'
      attribute :peer_choked?, 'peerIsChoked'
      attribute :peer_interested?, 'peerIsInterested'
      attribute :port, 'port'
      attribute :progress, 'progress', :type => RTransmission::Types::Percent
      attribute :rate_to_client, 'rateToClient'
      attribute :rate_to_peer, 'rateToPeer'

      def self.unmap(value)
        RTransmission::Types::Peer.new(value)
      end
    end
  end
end
