module Swaggers
  module MessageModel
    extend ActiveSupport::Concern

    included do
      swagger_schema :Message do
        key :required, [:content]
        property :id do
          key :type, :integer
          key :format, :int64
        end
        property :sender do
          key :type, :object
          key :'$ref', :Sender
        end
        property :content do
          key :type, :string
        end
        property :sent_at do
          key :type, :string
          key :format, :timestamp
          key :description, "Message sent time in user's time zone."
        end
        property :read_at do
          key :type, :string
          key :format, :timestamp
          key :description, "Message read time in user's time zone."
        end
      end

      swagger_schema :MessageCreate do
        key :required, [:content, :user_ids]
        property :content do
          key :type, :string
        end
        property :user_ids do
          key :type, :array
          items do
            key :type, :number
            key :format, :int64
          end
        end
      end
    end
  end
end
