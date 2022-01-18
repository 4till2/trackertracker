class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items
  has_many :entries, through: :items
  validates :name, presence: true, uniqueness: true

  def self.find_or_create_by_names(cats, user_id)
    return nil unless cats.present? && user_id.present?

    cats.map do |cat|
      Category.find_or_create_by!(user_id: user_id, name: cat).id
    end
  end
end
