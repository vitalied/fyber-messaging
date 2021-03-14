module Swaggers
  module UsersController
    extend ActiveSupport::Concern

    included do
      swagger_path '/users/{id}' do
        operation :get do
          key :tags, [:user]
          key :summary, 'Find User by ID'
          key :description, 'Return a user single entity.'
          parameter Helper.id_parameter('User Id')

          response 200 do
            key :description, :OK
            schema do
              key :'$ref', :User
            end
          end

          extend Swaggers::Responses::UnauthorizedError
          extend Swaggers::Responses::ForbiddenError

          response 404 do
            key :description, 'Not Found'
            schema do
              key :example, Helper.error_404_msg(:User)
            end
          end
        end
      end

      swagger_path '/users' do
        operation :post do
          key :tags, [:user]
          key :summary, 'Create User'
          key :description, 'Create a user entity.'
          parameter do
            key :name, :body
            key :in, :body
            key :description, 'User to Create'
            schema do
              property :user do
                key :'$ref', :UserCreate
              end
            end
          end

          response 201 do
            key :description, :Created
            schema do
              key :'$ref', :User
            end
          end

          extend Swaggers::Responses::UnauthorizedError
          extend Swaggers::Responses::ForbiddenError
          extend Swaggers::Responses::UnprocessableEntityError
        end
      end

      swagger_path '/users/{id}' do
        operation :put do
          key :tags, [:user]
          key :summary, 'Update User'
          key :description, 'Update a user entity.'
          parameter Helper.id_parameter('User Id')
          parameter do
            key :name, :body
            key :in, :body
            key :description, 'User to Update'
            schema do
              property :user do
                key :'$ref', :UserCreate
              end
            end
          end

          response 200 do
            key :description, :OK
            schema do
              key :'$ref', :User
            end
          end

          extend Swaggers::Responses::UnauthorizedError
          extend Swaggers::Responses::ForbiddenError

          response 404 do
            key :description, 'Not Found'
            schema do
              key :example, Helper.error_404_msg(:User)
            end
          end

          extend Swaggers::Responses::UnprocessableEntityError
        end

        operation :delete do
          key :tags, [:user]
          key :summary, 'Delete User'
          key :description, 'Delete a user entity.'
          parameter Helper.id_parameter('User Id')

          response 204 do
            key :description, 'No Content'
          end

          extend Swaggers::Responses::UnauthorizedError
          extend Swaggers::Responses::ForbiddenError

          response 404 do
            key :description, 'Not Found'
            schema do
              key :example, Helper.error_404_msg(:User)
            end
          end

          extend Swaggers::Responses::UnprocessableEntityError
        end
      end
    end
  end
end
