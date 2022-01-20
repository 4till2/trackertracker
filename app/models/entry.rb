class Entry < ApplicationRecord
  include Sourceable
  belongs_to :user
  belongs_to :item
  validates :date, presence: true


  #     group_by_day
  #     group_by_hour_of_day
  #     group_by_month
  #     group_by_minute
  #     group_by_week
  def self.totals_by_group(entries, group, range: 0, series: false)
    return unless entries.present? && group.present?

    entries.public_send(group,series: series, range: range, &:date).transform_values do |entries|
      entries.sum(&:amount)
    end
  end
end
