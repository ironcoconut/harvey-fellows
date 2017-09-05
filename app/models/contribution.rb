class Contribution < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :fellow
end
