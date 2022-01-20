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

  def total
    entries.sum(:amount)
  end

  def name=(value)
    write_attribute(:name, value.upcase)
  end

  # @param group = grouping, ie. group_by_hour, group_by_week ...
  # @param range = Date range to work with
  # @param format = key format ie. "%b %Y", "%-l %P"

  def total_per_item
    items.map { |item| [item.name, item.total] }
  end
end
