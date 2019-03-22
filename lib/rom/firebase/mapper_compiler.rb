require 'rom/mapper_compiler'
require_relative 'struct_compiler'

module ROM
  module Firebase
    class MapperCompiler < ::ROM::MapperCompiler
      def initialize(*args)
        super
        cache = Cache.new
        @struct_compiler = StructCompiler.new(cache: cache)
        @cache = cache.namespaced(:mappers)
        @mapper_options = self.class.mapper_options
      end
    end
  end
end
