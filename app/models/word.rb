require 'rest-client'
require 'addressable/uri'
require 'json'

class Word < ActiveRecord::Base
	def get_syns
		url = Addressable::URI.new(
			scheme: "http",
			host: "words.bighugelabs.com",
			path: "api/2/7b6ad11fccc077c6e8794f11597d63e9/#{self.name}/json",
		).to_s

		response = RestClient.get(url)
		JSON.parse(response)
	end
end
