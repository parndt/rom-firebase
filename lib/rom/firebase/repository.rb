module ROM
  module Firebase
    class Repository < ROM::Repository::Root
      commands :create, :delete, :update

      def all
        root.to_a
      end

      def count
        all.size
      end

      def create(params)
        find(super.key).one
      end

      def delete_all(keys)
        execute_threaded(keys, &method(:delete))
      end

      def find(primary_key)
        root.by_pk(primary_key)
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
        all.select(&block)
      end

      def update_all(keys, params)
        execute_threaded(keys) { |key| update(key, params) }
      end

      private

      def execute_threaded(list, &_block)
        list.each_with_object([]) do |item, threads|
          threads << Thread.new { yield item }
        end.each(&:join).map(&:value)
      end
    end
  end
end
