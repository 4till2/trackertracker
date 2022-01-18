class Entry < ApplicationRecord
  include Sourceable
  belongs_to :user
  belongs_to :item
end
