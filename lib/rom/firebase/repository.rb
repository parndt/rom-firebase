module ROM
  module Firebase
    module Repository
      def self.included(base)
        base.commands :create, :delete, :update
      end

      def all
        send(root.name.to_s)
      end

      def count
        all.to_a.size
      end

      def create(params)
        find(super.key).one
      end

      def delete_all(keys)
        execute_threaded(keys, &method(:delete))
      end

      def find(primary_key)
        all.by_pk(primary_key)
      end

      def first
        limit(1).to_a.first
      end

      def last
        all.to_a.last
      end

      def limit(count)
        all.limit(count)
      end

      def where(&block)
        all.to_a.select(&block)
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
