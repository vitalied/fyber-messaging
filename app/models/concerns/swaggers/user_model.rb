module Swaggers
  module UserModel
    extend ActiveSupport::Concern

    included do
      swagger_schema :UserCreate do
        key :required, [:first_name, :last_name, :email]
        property :first_name do
          key :type, :string
          key :maxLength, 100
        end
        property :last_name do
          key :type, :string
          key :maxLength, 100
        end
        property :email do
          key :type, :string
          key :maxLength, 100
        end
        property :time_zone do
          key :type, :string
        end
      end

      swagger_schema :User do
        allOf do
          schema do
            property :id do
              key :type, :integer
              key :format, :int64
            end
            property :token do
              key :type, :string
            end
          end
          schema do
            key :'$ref', :UserCreate
          end
        end
      end

      swagger_schema :Sender do
        allOf do
          schema do
            key :'$ref', :User
          end
        end
      end
    end
  end
end
