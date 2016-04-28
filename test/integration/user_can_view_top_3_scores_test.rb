require 'test_helper'

class UserCanViewTop3Scores < ActionDispatch::IntegrationTest
  test "display the top three out of four scores" do
    skip
    level = Level.create(
      title: "Easy",
      text: "This is the first level of the typing test."
    )

    level.attempts.create(text: "This is the first level of the typing test.")
    level.attempts.create(text: "This is the first level of the typing .")
    level.attempts.create(text: "This is the first level of the")
    level.attempts.create(text: "This is")

    visit attempts_path
    within("ul:first") do
      assert page.has_content? "This is the first level of the typing test. Level: Easy"
    end
    within("ul:nth-child(2)") do
      assert page.has_content? "This is the first level of the typing . Level: Easy"
    end
    # within("ul:nth-child(3)") do
      assert page.has_content? "This is the first level of the Level: Easy"
    # end
    within("ul:last") do
      refute page.has_content? "This is Level: Easy"
    end
  end
end
