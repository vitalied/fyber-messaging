module Swaggers
  class Error
    include Swagger::Blocks

    swagger_schema :Error do
      property :errors do
        key :type, :string
      end
    end

    swagger_schema :Errors do
      property :errors do
        key :type, :object
      end
    end
  end
end
