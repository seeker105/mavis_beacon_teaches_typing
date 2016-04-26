class Attempt < ActiveRecord::Base
  belongs_to :level
  validates :text, presence: true

  # def percent_correct
  #   error_count = 0
  #   master = level.text
  #   attempt = level.attempts.last.text
  #   0.step(master.length - 1) do |i|
  #     error_count += 1 if master[i] != attempt[i] if attempt[i]
  #   end
  #   ((master.length - error_count)*100) / master.length
  # end
  def percent_correct
    correct_count = 0
    master = level.text
    attempt = level.attempts.last.text
    0.step(attempt.length - 1) do |i|
      correct_count += 1 if master[i] == attempt[i]
    end
    (correct_count * 100) / master.length
  end
end
