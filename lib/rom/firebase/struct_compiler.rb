require 'rom/struct_compiler'

module ROM
  module Firebase
    class StructCompiler < ROM::StructCompiler
      # @api private
      def build_class(name, parent, ns, &block)
        Dry::Core::ClassBuilder.
          new(name: class_name(name), parent: parent, namespace: ns).
          call do |struct|
            struct.transform_types { |type| type.optional? ? type.required(false) : type }
            block.call(struct)
          end
      end
    end
  end
end
