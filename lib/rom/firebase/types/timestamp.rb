# frozen_string_literal: true

require 'firebase/server_value'

module ROM
  module Firebase
    module Types
      Timestamp = ::ROM::Types::Strict::Hash
                  .schema('.sv' => ::ROM::Types::Strict::String)
                  .default(::Firebase::ServerValue::TIMESTAMP.freeze)
                  .meta(read: ::ROM::Types::Strict::Integer)
    end
  end
end
