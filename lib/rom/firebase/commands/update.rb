# frozen_string_literal: true

require 'firebase/server_value'
require 'rom/http/commands/update'

module ROM
  module Firebase
    module Commands
      class Update < ROM::HTTP::Commands::Update
        adapter :firebase

        def execute(tuples)
          keys = threaded([tuples].flatten) { |t| super(add_timestamps(t)) }
                 .map { |response| response[relation.primary_key] }
          relation.where { |node| keys.include?(node[relation.primary_key]) }
        end

        private

        def add_timestamps(tuple)
          return tuple unless keys.include?(:updatedAt)

          { updatedAt: ::Firebase::ServerValue::TIMESTAMP }.merge(tuple)
        end

        def keys
          relation.mapper.header.attributes.keys
        end

        def threaded(tuples)
          tuples.each_with_object([]) do |tuple, threads|
            threads << Thread.new { yield tuple }
          end.each(&:join).map(&:value).flatten
        end
      end
    end
  end
end
