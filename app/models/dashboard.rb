class Dashboard < ApplicationRecord
  belongs_to :user
  has_many :displays
end
