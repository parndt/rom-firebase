require 'firebase/server_value'

module ROM
  module Firebase
    module Types
      TIMESTAMP = ::ROM::Types::Strict::Hash
                  .schema('.sv' => ::ROM::Types::Strict::String)
                  .default(::Firebase::ServerValue::TIMESTAMP.freeze)
                  .meta(read: ::ROM::Types::Strict::Integer)
    end
  end
end
