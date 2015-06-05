class Work < ActiveRecord::Base
  validates :team, :title, :introduction, presence: true
end
