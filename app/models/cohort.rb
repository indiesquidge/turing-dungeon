class Cohort < ActiveRecord::Base
  has_many :users

  def commits
    users.flat_map { |user| user.commits }.sort_by(&:created_at).reverse.first(10)
  end

  def to_param
    name
  end
end
