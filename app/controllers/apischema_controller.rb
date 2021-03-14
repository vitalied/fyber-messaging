class ApischemaController < ApplicationPublicController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'

    info do
      key :version, '1.0.0'
      key :title, 'Fyber Messaging API'
      key :description, ''
      contact do
        key :name, 'Fyber'
      end
    end
    key :consumes, ['application/json']
    key :produces, ['application/json']
    security_definition :Bearer do
      key :type, :apiKey
      key :name, :Authorization
      key :in, :header
    end
  end

  # A list of classes that have swagger_* declarations to be shown in all environments.
  PUBLIC_CLASSES = [
    self,

    MessagesController,
    Message,
    UsersController,
    User,

    # Swagger resources
    Swaggers::Error,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(PUBLIC_CLASSES)
  end
end
