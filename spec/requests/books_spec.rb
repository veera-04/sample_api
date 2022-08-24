require 'rails_helper'

describe 'Books API', type: :request do
        let!(:first_author){FactoryBot.create(:author,first_name:'Stanley',last_name:'S',age:45)}
        let!(:second_author){FactoryBot.create(:author,first_name:'Ramya',last_name:'Sankari',age:24)}
        describe 'GET /books' do
                before do
                        FactoryBot.create(:book,title:'hulk',author:first_author)
                        FactoryBot.create(:book,title:'thor',author:second_author)
                end
                it 'returns all books' do
                        get '/api/v1/books'
                        expect(response).to have_http_status(:success)
                        expect(response_body.size).to eq(2)
                        expect(response_body).to eq(
                                [
                                        {
                                        'id'=>1,
                                        'title'=>'hulk',
                                        'author'=>'Stanley S',
                                        'author_age'=>45
                                        },
                                        {
                                        'id'=>2,
                                        'title'=>'thor',
                                        'author'=>'Ramya Sankari',
                                        'author_age'=>24
                                        }
                                ]
                        )
                end

                it 'returns a subset based on pagination' do
                        get '/api/v1/books', params: {limit: 1}
                        expect(response).to have_http_status(:success)
                        expect(response_body.size).to eq(1)
                end

        end
        describe 'POST /books' do
                it 'creates a new book' do
                        expect{
                        post '/api/v1/books',params: {
                                book: {title: 'Harry'},
                                author: {first_name: 'Veera', last_name: 'S',age: 22}
                                }
                        }.to change {Book.count}.from(0).to(1)
                expect(response).to have_http_status(:created)
                expect(response_body).to eq(
                        {
                                'id'=>1,
                                'title'=>'Harry',
                                'author'=>'Veera S',
                                'age'=>22
                        }
                )
                end
        end
        describe 'DELETE /books/:id' do
                let!(:book){FactoryBot.create(:book,title:'thor',author:first_author)}
                it 'deletes a book' do
                        expect{
                        delete "/api/v1/books/#{book.id}"}.to change {Book.count}.from(1).to(0)
                        expect(response).to have_http_status(:no_content)
                end
        end
end