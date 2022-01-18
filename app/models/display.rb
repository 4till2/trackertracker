class Display < ApplicationRecord
  belongs_to :user
  belongs_to :dashboard
  has_many :sources
end
