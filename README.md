RTransmission
-------------

Ruby Transmission Bindings

Basic Usage
-----------

    require 'rtransmission'

    RTransmission::Client.session(:user => 'foo', :password => 'bar') do |session|
      session.speed_limit_down_enabled = false

      url = 'http://torrents.gentoo.org/torrents/livedvd-x86-amd64-32ul-11.1.torrent'
      torrent = RTransmission::Torrent.add(session, :url => url)
      torrent = RTransmission::Torrent.list(session)[0]

      files = torrent.files
      files.each { |f| puts f.name }

      torrent.upload_limited = false
    end

Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>  
All rights reserved.  
Use of this source code is governed by a BSD-style license that can be found in the COPYING file.
