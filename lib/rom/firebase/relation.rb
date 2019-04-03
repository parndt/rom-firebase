# frozen_string_literal: true

require 'rom/http/relation'

module ROM
  module Firebase
    class Relation < ROM::HTTP::Relation
      adapter :firebase

      def limit(count, key: DEFAULT_ORDER_BY)
        with_params(order_by(key).merge(limitToLast: count))
      end

      def by_pk(primary_key)
        with_path(CGI.escape(primary_key))
      end

      def where(&block)
        to_a.select(&block)
      end

      private

      DEFAULT_ORDER_BY = 'createdAt'
      private_constant :DEFAULT_ORDER_BY

      def order_by(key)
        { orderBy: %("#{key}") }
      end
    end
  end
end
