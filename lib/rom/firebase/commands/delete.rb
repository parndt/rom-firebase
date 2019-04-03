# frozen_string_literal: true

require 'rom/http/commands/delete'

module ROM
  module Firebase
    module Commands
      class Delete < ROM::HTTP::Commands::Delete
        adapter :firebase

        def execute(keys)
          keys.each_with_object([]) do |key, threads|
            threads << Thread.new { relation.by_pk(key).delete }
          end.each(&:join).map(&:value).flatten
        end
      end
    end
  end
end
