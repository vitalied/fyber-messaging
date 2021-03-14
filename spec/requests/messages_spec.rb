require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  context 'unauthorized' do
    context 'GET /messages' do
      it 'should return unauthorized status' do
        get messages_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'authorized' do
    let!(:user) { create :user }
    let!(:recipient_user) { create :user }
    let(:valid_params) { { content: Faker::Lorem.paragraph, user_ids: [recipient_user.id] } }
    let(:invalid_params) { { content: nil } }
    let(:token) { user.token }

    context 'GET /messages' do
      let!(:message) { create :message, user_ids: [user.id] }

      before do
        get messages_path, headers: token_headers
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected data' do
        expect(body.first[:id]).to eql(message.id)

        get messages_path, headers: token_headers

        expect(body).to eql([])
      end
    end

    context 'POST /messages' do
      context 'with valid params' do
        let(:post_request) { post messages_path, params: { message: valid_params }, headers: token_headers, as: :json }

        it 'creates a new Message entity' do
          expect { post_request }.to change(Message, :count).by(1)
                                 .and change(Recipient, :count).by(1)
        end

        it 'renders a JSON response with the new User entity' do
          post_request

          expect(response).to have_http_status(:created)
          expect(body_errors).not_to be_present

          expect(body[:content]).to eql(valid_params[:content])
          expect(body[:sender][:id]).to eql(user.id)
        end
      end

      context 'with invalid parameters' do
        let(:post_request) { post messages_path, params: { message: invalid_params }, headers: token_headers, as: :json }

        it 'does not create a new User entity' do
          expect { post_request }.not_to change(Message, :count)
        end

        it 'renders a JSON response with errors for the new entity' do
          post_request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(body_errors).to be_present
        end
      end
    end
  end
end
