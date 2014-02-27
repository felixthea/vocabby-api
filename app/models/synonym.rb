class Synonym < ActiveRecord::Base
	validates_uniqueness_of :word_id, scope: :name
end
