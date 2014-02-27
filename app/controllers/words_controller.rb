class WordsController < ApplicationController

	def new
	end

	def create
		@word = Word.new(word_params.merge({user_id: current_user.id}))
		if @word.save
			@word.create_syns
			redirect_to word_url(@word.id)
		else
			render :new
		end
	end

	def show
		@word = Word.find(params[:id])
		render :show
	end

	def index
		@words = Word.find_all_by_user_id(current_user.id)
		render json: @words
	end

	private

	def word_params
		params.require(:word).permit(:name)
	end
end
