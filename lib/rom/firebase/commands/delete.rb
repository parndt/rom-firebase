require 'rom/http/commands/delete'

module ROM
  module Firebase
    module Commands
      class Delete < ROM::HTTP::Commands::Delete
        adapter :firebase

        def execute(primary_key)
          relation.by_pk(primary_key).delete
          []
        end
      end
    end
  end
end
