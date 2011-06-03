# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'json'

module RTransmission
  class Response
    attr_accessor :body
    attr_accessor :prefix
    attr_accessor :block

    def initialize(body, prefix, block)
      @body = body
      @prefix = prefix
      @block = block
    end

    def parse
      body = JSON.parse(@body)
      raise RTransmission::Exception.new((@prefix ? @prefix + ': ' : '') + body['result']) if body['result'] != 'success'
      return @block.call(body['arguments']) if @block
      body['arguments']
    end
  end
end
