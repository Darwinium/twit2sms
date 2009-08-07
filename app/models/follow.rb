class Follow < ActiveRecord::Base
  belongs_to :user
  has_many :twits
end
