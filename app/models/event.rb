class Event < ApplicationRecord
  belongs_to :gym
  enum event_type: [:ad, :class, :event]
end
