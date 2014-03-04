class WordsController < ApplicationController

	def new
	end

	def create
		new_word_params = {}
		new_word_params[:name] = word_params[:name]
		user = User.find_by_session_token(word_params[:session_token])
		new_word_params[:user_id] = user.id

		@word = Word.new(new_word_params)
		if @word.save
			@word.create_syns
			render json: @word
		else
			render json: @word.errors.full_messages, status: 422
		end
	end

	def show
		@word = Word.find(params[:id])
		render :show
	end

	def index
		user = User.find_by_session_token(params[:session_token])
		words = Word.find_all_by_user_id(user.id)
		@words_hash = {}	
		words.each do |word|
			word.synonyms.each do |syn|
				@words_hash[syn.name] = word.name
			end
		end
		
		render json: @words_hash
	end

	private

	def word_params
		params.require(:word).permit(:name, :session_token)
	end
end
