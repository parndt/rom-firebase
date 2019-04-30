# frozen_string_literal: true

require 'firebase/server_value'

module ROM
  module Firebase
    module Types
      Timestamp = ::ROM::Types::Strict::Hash
                  .schema(
                    ::Firebase::ServerValue::TIMESTAMP.keys.first =>
                    ::ROM::Types::Strict::String.constrained(
                      format: ::Firebase::ServerValue::TIMESTAMP.values.first
                    )
                  )
                  .meta(read: ::ROM::Types::Integer.default(nil))
    end
  end
end
