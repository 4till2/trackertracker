module Sourceable
  extend ActiveSupport::Concern
  included do
    has_many :sources, as: :sourceable
  end
end