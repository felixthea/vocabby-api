class WordsController < ApplicationController

	def new
	end

	def create
		@word = Word.new(word_params.merge({user_id: current_user.id}))
		if @word.save
			redirect_to word_url(@word.id)
		else
			render :new
		end
	end

	def show
		@word = Word.find(params[:id])
		render :show
	end

	private

	def word_params
		params.require(:word).permit(:name)
	end
end
