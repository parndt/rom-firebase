# frozen_string_literal: true

module ROM
  module Firebase
    class Repository < ROM::Repository::Root
      commands :create, :delete, :update

      def all
        root.to_a
      end

      def by_pk(primary_key)
        root.by_pk(primary_key)
      end
      alias find by_pk
      alias by_key by_pk

      def count
        all.size
      end

      def first
        limit(1).to_a.first
      end

      def last
        all.last
      end

      def limit(count)
        root.limit(count)
      end

      def where(&block)
        root.where(&block)
      end
    end
  end
end
