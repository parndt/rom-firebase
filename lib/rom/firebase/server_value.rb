# frozen_string_literal: true

# We are overriding this to support the dry-types requirement of a symbol key
module Firebase
  class ServerValue
    TIMESTAMP = { '.sv': 'timestamp' }.freeze
  end
end
