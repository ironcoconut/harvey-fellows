class Fellow < ApplicationRecord
  has_many :contributions
  belongs_to :user, optional: true

  def total_goal
    health_insurance = 12000
    retirement = 10000

    goal + health_insurance + fica_taxes + retirement
  end

  def health_insurance
    @health_insurance ||= 12000.0
  end

  def fica_taxes
    @fica_taxes ||= goal * 0.0765
  end

  def retirement
    @retirement ||= 10000.0
  end
end
