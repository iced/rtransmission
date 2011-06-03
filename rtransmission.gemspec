require File.expand_path("../lib/rtransmission/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "rtransmission"
  s.version = RTransmission::VERSION::STRING
  s.author = "Andrew Kirilenko"
  s.email = "andrew.kirilenko@gmail.com"
  s.homepage = "http://github.com/iced/rtransmission"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby Transmission Bindings"
  s.description = "RTransmission allows you to interract with Transmission daemon"
  s.files = ["COPYING", "README.md", "rtransmission.gemspec"] + Dir.glob('lib/**/*')
  s.require_path = "lib"
  s.has_rdoc = false
end
