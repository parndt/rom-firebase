require 'rom/http/commands/create'

module ROM
  module Firebase
    module Commands
      class Create < ROM::HTTP::Commands::Create
        adapter :firebase

        def execute(tuples)
          relation.by_pk(super.first[:key])
        end
      end
    end
  end
end
