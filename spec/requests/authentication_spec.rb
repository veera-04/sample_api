require 'rails_helper'

describe 'Aunthenticate User' , type: :request do
        describe 'POST /authenticate' do
                let(:user){FactoryBot.create(:user,username: 'uname')}
                it 'authenticates the user' do
                        post '/api/v1/authenticate', params: {username: user.username,pwd: 'passowrd'}

                        expect(response).to have_http_status(:created)
                        expect(response_body).to eq({'token'=>'123'})
                end

                it 'shows error when username is missing' do
                        post '/api/v1/authenticate', params: {pwd: 'password'}
                        expect(response).to have_http_status(:unprocessable_entity)
                end

                it 'shows error when password is missing' do
                        post '/api/v1/authenticate', params: {username: 'uname'}
                        expect(response).to have_http_status(:unprocessable_entity)
                end
        end
end