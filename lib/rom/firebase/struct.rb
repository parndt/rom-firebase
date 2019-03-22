module ROM
  module Firebase
    class Struct < ROM::Struct
      transform_types { |type| type.optional? ? type.required(false) : type }
    end
  end
end
