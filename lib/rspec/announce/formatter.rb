# -*- encoding : utf-8 -*-
require 'rspec/core/formatters/documentation_formatter'

# $ echo "--format EopCore::IntegrationTesting::RspecAnnouncementFormatter" > $PROJECT_HOME/.rspec

module Rspec
  module Announce
    class Formatter < RSpec::Core::Formatters::DocumentationFormatter
      def announce(msg)
        @announcements << msg
      end

      def example_started(example)
        super
        @announcements = []
      end

      def example_passed(passed)
        super
        @announcements.each do |m|
          output.puts success_color("#{current_indentation}  #{m}")
        end
      end
    end
  end
end
