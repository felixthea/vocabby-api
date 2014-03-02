require 'rest-client'
require 'addressable/uri'
require 'json'

class Word < ActiveRecord::Base
	def create_syns
		syn_arr = []
		url = Addressable::URI.new(
			scheme: "http",
			host: "words.bighugelabs.com",
			path: "api/2/7b6ad11fccc077c6e8794f11597d63e9/#{self.name}/json",
		).to_s

		response = RestClient.get(url)
		resp_json = JSON.parse(response)
		resp_json.each do |k,v|
			syn_arr += resp_json[k]["syn"] if resp_json[k]["syn"]
		end

		save_syns(syn_arr)
	end

	def save_syns(syn_arr)
		syn_arr.each do |syn|
			Synonym.create(name: syn, word_id: self.id)
		end
	end

	has_many :synonyms, dependent: :destroy
	validates_uniqueness_of :name, scope: :user_id
end
