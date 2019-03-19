require 'rom/http/commands/update'

module ROM
  module Firebase
    module Commands
      class Update < ROM::HTTP::Commands::Update
        adapter :firebase

        def execute(key, params)
          relation.by_pk(key).update(params)
          relation.by_pk(key)
        end
      end
    end
  end
end
