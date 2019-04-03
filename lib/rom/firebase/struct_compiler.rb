# frozen_string_literal: true

require 'rom/struct_compiler'

module ROM
  module Firebase
    class StructCompiler < ROM::StructCompiler
      # @api private
      def build_class(name, parent, namespace, &_block)
        Dry::Core::ClassBuilder
          .new(name: class_name(name), parent: parent, namespace: namespace)
          .call do |struct|
            struct.transform_types { |t| t.optional? ? t.required(false) : t }
            yield struct
          end
      end
    end
  end
end
