class Sign < ActiveRecord::Base
    belongs_to :account
    has_many :tokens
end
