require 'rspec/announce/version'

module Rspec
  module Announce
    def announce(msg, &blk)
      RSpec.configuration.formatters.each do |f|
        if f.respond_to?(:announce)
          f.announce(msg)
        end
      end
      blk.call if block_given?
    end
  end
end
