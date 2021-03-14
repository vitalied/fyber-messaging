module Swaggers
  module MessagesController
    extend ActiveSupport::Concern

    included do
      swagger_path '/messages' do
        operation :get do
          key :tags, [:message]
          key :summary, "List user's new messages"
          key :description, "Returns a list of user's new messages."

          response 200 do
            key :description, :OK
            schema do
              key :type, :array
              items do
                key :type, :object
                key :'$ref', :Message
              end
            end
          end

          extend Swaggers::Responses::UnauthorizedError
          extend Swaggers::Responses::ForbiddenError
        end
      end

      swagger_path '/messages' do
        operation :post do
          key :tags, [:message]
          key :summary, 'Create Message'
          key :description, 'Create a message entity.'
          parameter do
            key :name, :body
            key :in, :body
            key :description, 'Message to Create'
            schema do
              property :message do
                key :'$ref', :MessageCreate
              end
            end
          end

          response 201 do
            key :description, :Created
            schema do
              key :'$ref', :Message
            end
          end

          extend Swaggers::Responses::UnauthorizedError
          extend Swaggers::Responses::ForbiddenError
          extend Swaggers::Responses::UnprocessableEntityError
        end
      end
    end
  end
end
