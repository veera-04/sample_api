module Api 
        module V1 
                class AuthenticationController < ApplicationController
                        rescue_from ActionController::ParameterMissing, with: :parameter_missing
                        def create
                                puts params.require(:username).inspect
                                puts params.require(:pwd).inspect
                                render json: {token: '123'},status: :created
                        end
                        private
                        def parameter_missing(e)
                                render json: {error: e.message},status: :unprocessable_entity
                        end
                end
        end
end