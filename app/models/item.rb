class Item < ApplicationRecord
  include Sourceable
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :entries, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def total
    entries.sum(:amount)
  end
end
