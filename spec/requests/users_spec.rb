require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create :user }
  let(:valid_user) { build :user }
  let(:valid_params) { { first_name: valid_user.first_name, last_name: valid_user.last_name, email: valid_user.email } }
  let(:invalid_params) { { first_name: nil } }

  context 'unauthorized' do
    context 'GET /users/:id' do
      context 'when User entity exist' do
        before do
          get user_path(user.id)
        end

        it 'returns a success response' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns expected data' do
          expect(body[:id]).to eql(user.id)
          expect(body[:token]).to eql(user.token)
          expect(body[:first_name]).to eql(user.first_name)
          expect(body[:last_name]).to eql(user.last_name)
          expect(body[:email]).to eql(user.email)
          expect(body_errors).not_to be_present
        end
      end

      context 'when User entity does not exist' do
        before do
          get user_path(:fake_id)
        end

        it 'returns an error response' do
          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end

    context 'POST /users' do
      context 'with valid params' do
        let(:post_request) { post users_path, params: { user: valid_params }, as: :json }

        it 'creates a new User entity' do
          expect { post_request }.to change(User, :count).by(1)
        end

        it 'renders a JSON response with the new User entity' do
          post_request

          expect(response).to have_http_status(:created)
          expect(body_errors).not_to be_present

          expect(body[:first_name]).to eql(valid_params[:first_name])
          expect(body[:last_name]).to eql(valid_params[:last_name])
          expect(body[:email]).to eql(valid_params[:email])
        end
      end

      context 'with invalid parameters' do
        let(:post_request) { post users_path, params: { user: invalid_params }, as: :json }

        it 'does not create a new User entity' do
          expect { post_request }.not_to change(User, :count)
        end

        it 'renders a JSON response with errors for the new entity' do
          post_request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(body_errors).to be_present
        end
      end
    end
  end

  context 'authorized' do
    let(:token) { user.token }

    context 'PATCH/PUT /users/:id' do
      context 'with valid params' do
        before do
          put user_path(user), params: { user: valid_params }, headers: token_headers, as: :json
        end

        it 'updates the User entity' do
          user.reload

          expect(user.first_name).to eql(valid_params[:first_name])
          expect(user.last_name).to eql(valid_params[:last_name])
          expect(user.email).to eql(valid_params[:email])
        end

        it 'renders a JSON response with the updated User entity' do
          expect(response).to have_http_status(:ok)
          expect(body_errors).not_to be_present

          expect(body[:first_name]).to eql(valid_params[:first_name])
          expect(body[:last_name]).to eql(valid_params[:last_name])
          expect(body[:email]).to eql(valid_params[:email])
        end
      end

      context 'with invalid params' do
        before do
          put user_path(user), params: { user: invalid_params }, headers: token_headers, as: :json
        end

        it 'renders a JSON response with errors for the User entity' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(body_errors).to be_present
        end
      end

      context 'when User entity does not exist' do
        before do
          put user_path(:fake_id), headers: token_headers, as: :json
        end

        it 'returns a failure response containing errors' do
          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end

    context 'DELETE /users/:id' do
      context 'when User entity exist' do
        let(:delete_request) { delete user_path(user), headers: token_headers, as: :json }

        it 'deletes the User entity' do
          expect { delete_request }.to change(User, :count).by(-1)
        end

        it 'returns a success response' do
          delete_request

          expect(response).to have_http_status(:no_content)
          expect(body_errors).not_to be_present
        end
      end

      context 'when User entity does not exist' do
        let(:delete_request) { delete user_path(:fake_id), headers: token_headers, as: :json }

        it 'does not  delete the User entity' do
          expect { delete_request }.not_to change(User, :count)
        end

        it 'returns a failure response containing errors' do
          delete_request

          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end
  end
end
