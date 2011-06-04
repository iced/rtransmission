# Copyright (c) 2011, Andrew Kirilenko <andrew.kirilenko@gmail.com>
# All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found in the COPYING file.

require 'net/http'

module RTransmission
  class Client
    attr_accessor :host
    attr_accessor :port
    attr_accessor :path
    attr_accessor :user
    attr_accessor :password

    attr_reader :session_id

    def self.session(args = {}, &block)
      client = RTransmission::Client.new(args)
      session = RTransmission::Session.new(client)

      block.call(session) if block

      session
    end

    def self.rpc_name_to_ruby_name(rpc_name)
      name = nil
      if rpc_name.index('-')
        name = rpc_name.gsub('-', '_')
      else
        name = rpc_name.gsub(/[A-Z]/) { |x| '_' + x.downcase }
      end

      name
    end

    def initialize(args = {})
      @host = args[:host] || 'localhost'
      @port = args[:port] || 9091
      @path = args[:path] || '/transmission/rpc'
      @user = args[:user] || nil
      @password = args[:password] || nil
    end

    def call(request)
      req = Net::HTTP::Post.new(@path)
      req.basic_auth(@user, @password) if @user || @password
      req['X-Transmission-Session-Id'] = @session_id if @session_id
      req.body = request.to_json

      res = Net::HTTP.start(@host, @port) do |http|
        http.request(req)
      end

      if res.code.to_i == 409
        @session_id = res['X-Transmission-Session-Id']
        return call(request)
      end

      return RTransmission::Response.new(res.body, request.response_prefix, request.response_block).parse
    end
  end
end
