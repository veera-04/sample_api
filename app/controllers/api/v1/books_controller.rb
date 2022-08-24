module Api
  module V1
    class BooksController < ApplicationController

      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: [:create,:destroy]

      def index
        books=Book.limit(limit).offset(params[:offset])
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        author=Author.create!(author_params)
        book=Book.new(book_params.merge(author_id: author.id))
        if book.save
          render json: BookRepresenter.new(book).as_json,status: :created
        else
          render json:book.errors,status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private

      def authenticate_user
        token, _options=token_and_options(request)
        user_id=AuthenticationTokenService.decode(token)
        User.find(user_id)
        rescue ActiveRecord::RecordNotFound
          render status: :unauthorized
      end

      def limit
        [
          params.fetch(:limit,100).to_i,
          100
        ].min
      end

      def book_params
        params.require(:book).permit(:title)
      end

      def author_params
        params.require(:author).permit(:first_name,:last_name,:age)
      end

    end
  end
end
