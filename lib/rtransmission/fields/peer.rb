# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

module RTransmission
  module Fields
    class Peer < RTransmission::Field
      define_attribute :address, 'address'
      define_attribute :client_choked?, 'clientIsChoked'
      define_attribute :client_interested?, 'clientIsInterested'
      define_attribute :client_name, 'clientName'
      define_attribute :flag_str, 'flagStr'
      define_attribute :downloading_from?, 'isDownloadingFrom'
      define_attribute :encrypted?, 'isEncrypted'
      define_attribute :incoming?, 'isIncoming'
      define_attribute :utp?, 'isUTP'
      define_attribute :uploading_to?, 'isUploadingTo'
      define_attribute :peer_choked?, 'peerIsChoked'
      define_attribute :peer_interested?, 'peerIsInterested'
      define_attribute :port, 'port'
      define_attribute :progress, 'progress', :type => RTransmission::Fields::Percent
      define_attribute :rate_to_client, 'rateToClient'
      define_attribute :rate_to_peer, 'rateToPeer'

      def self.unmap(value)
        RTransmission::Fields::Peer.new(value)
      end
    end
  end
end
