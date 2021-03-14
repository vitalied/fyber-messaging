class UserSerializer < ActiveModel::Serializer
  attributes :id, :token, :first_name, :last_name, :email, :time_zone
end
