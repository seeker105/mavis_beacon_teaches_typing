class Attempt < ActiveRecord::Base
  belongs_to :level
  validates :text, presence: true

  def percent_correct
    correct_count = 0
    # byebug
    master = level.text
    0.step(text.length - 1) do |i|
      correct_count += 1 if master[i] == text[i]
    end
    (correct_count * 100) / master.length
  end
end
