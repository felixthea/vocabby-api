class Synonym < ActiveRecord::Base
	validates_uniqueness_of :user_id, scope: :name
end
