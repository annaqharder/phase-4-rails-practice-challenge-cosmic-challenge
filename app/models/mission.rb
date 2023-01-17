class Mission < ApplicationRecord
  belongs_to :scientist
  belongs_to :planet

  validates_presence_of :name, :scientist, :planet
  validates :scientist, uniqueness: { scope: :name }

end
