# frozen_string_literal: true

require 'firebase/server_value'
require 'rom/http/commands/create'

module ROM
  module Firebase
    module Commands
      class Create < ROM::HTTP::Commands::Create
        adapter :firebase

        def execute(tuples)
          keys = threaded([tuples].flatten) { |t| super(add_timestamps(t)) }
                 .map { |response| response[relation.primary_key] }
          relation.where { |node| keys.include?(node[relation.primary_key]) }
        end

        private

        TIMESTAMPS = %i[createdAt updatedAt].freeze

        def add_timestamp(tuple, key)
          return tuple unless keys.include?(key)

          { key => ::Firebase::ServerValue::TIMESTAMP }.merge(tuple)
        end

        def add_timestamps(tuple)
          add_timestamp(
            add_timestamp(tuple, :createdAt),
            :updatedAt
          )
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
