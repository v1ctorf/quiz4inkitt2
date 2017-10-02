class Answer < ActiveRecord::Base
    validates :option, :presence => true
end
