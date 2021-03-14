require 'rails_helper'

RSpec.describe MessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/messages').to route_to('messages#index', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/messages').to route_to('messages#create', format: 'json')
    end
  end
end
