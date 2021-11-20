class Case < ApplicationRecord
  has_one :engineer
  has_many :problems

  validates_uniqueness_of(:case_name)
end
