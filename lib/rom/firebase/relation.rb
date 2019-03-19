require 'rom/http/relation'

module ROM
  module Firebase
    class Relation < ROM::HTTP::Relation
      adapter :firebase

      def limit(count, key: DEFAULT_KEY)
        with_params(order_by(key).merge(limitToLast: count))
      end

      def by_pk(primary_key)
        with_path(CGI.escape(primary_key))
      end

      private

      DEFAULT_KEY = 'createdAt'.freeze

      def order_by(key)
        { orderBy: %("#{key}") }
      end
    end
  end
end
