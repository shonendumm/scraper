class Diary < ApplicationRecord
  validates_presence_of :title, :link
end
