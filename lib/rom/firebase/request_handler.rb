require 'firebase'

module ROM
  module Firebase
    class RequestHandler
      def call(dataset)
        client(dataset.uri).send(
          MAPPING[dataset.request_method],
          dataset.uri.path.gsub(%r{\A/}, ''),
          dataset.params
        )
      end

      def initialize(config)
        @config = config
      end

      private

      MAPPING = {
        delete: :delete,
        get: :get,
        post: :push,
        put: :update
      }.freeze

      def client(uri)
        ::Firebase::Client.new("#{uri.scheme}://#{uri.host}", config)
      end

      def config
        File.read(@config)
      end
    end
  end
end
