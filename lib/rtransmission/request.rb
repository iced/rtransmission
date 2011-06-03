# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'json'

module RTransmission
  class Request
    attr_accessor :method
    attr_accessor :arguments
    attr_accessor :response_prefix
    attr_accessor :response_block

    def initialize(method, arguments, response_prefix, &response_block)
      @method = method
      @arguments = arguments
      @response_prefix = response_prefix
      @response_block = response_block
    end

    def to_json
      {'method' => @method, 'arguments' => @arguments}.to_json
    end
  end
end
