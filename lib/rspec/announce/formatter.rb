# -*- encoding : utf-8 -*-
RSpec::Support.require_rspec_core 'formatters/documentation_formatter'

# $ echo "--format EopCore::IntegrationTesting::RspecAnnouncementFormatter" > $PROJECT_HOME/.rspec

module Rspec
  module Announce
    class Formatter < RSpec::Core::Formatters::DocumentationFormatter
      RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished,
                                  :example_passed, :example_pending, :example_failed, :example_started

      def announce(msg)
        @announcements << msg
      end

      def example_started(example)
        @announcements = []
      end

      def example_passed(passed)
        super
        @announcements.each do |m|
          output.puts success_color("#{current_indentation}  #{m}")
        end
      end

      private 

      def success_color(s)
        RSpec::Core::Formatters::ConsoleCodes.wrap(s, :success)
      end
    end
  end
end
