module ROM
  module Firebase
    class ResponseHandler
      def self.call(response, dataset)
        new(response, dataset).call
      end

      def initialize(response, dataset)
        @response = response
        @dataset = dataset
      end

      def call
        return create_response if options[:request_method] == :post
        return [path_response] unless path.nil? || path.empty?
        return [] if options[:request_method] == :delete # delete always succeeds

        collection_response
      end

      private

      attr_accessor :dataset, :response

      def create_response
        { key: response_body['name'] }
      end

      def options
        dataset.options
      end

      def path
        options[:path]
      end

      def collection_response
        response_body.map(&method(:response_hash))
      end

      def path_response
        response_hash(path, response_body || {})
      end

      def response_body
        response.body || {}
      end

      def response_hash(firebase_key, model)
        { key: firebase_key }.merge(
          model.map { |key, value| [key.to_sym, value] }.to_h
        )
      end
    end
  end
end
