require 'rails_helper'

describe 'Aunthenticate User' , type: :request do
        describe 'POST /authenticate' do
                let(:user){FactoryBot.create(:user,username: 'uname',password: 'password')}
                it 'authenticates the user' do
                        post '/api/v1/authenticate', params: {username: user.username,pwd: 'password'}

                        expect(response).to have_http_status(:created)
                        expect(response_body).to eq({'token'=>'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w'})
                end

                it 'shows error when username is missing' do
                        post '/api/v1/authenticate', params: {pwd: 'password'}
                        expect(response).to have_http_status(:unprocessable_entity)
                end

                it 'shows error when password is missing' do
                        post '/api/v1/authenticate', params: {username: 'uname'}
                        expect(response).to have_http_status(:unprocessable_entity)
                end

                it 'returns error when password is incorrect' do
                        post '/api/v1/authenticate', params: {username: user.username, pwd: 'incorrect'}

                        expect(response).to have_http_status(:unauthorized)
                end
        end
end