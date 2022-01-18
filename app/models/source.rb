class Source < ApplicationRecord
  belongs_to :display
  belongs_to :sourceable, polymorphic: true
end
