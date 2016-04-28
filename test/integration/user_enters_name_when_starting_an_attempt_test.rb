require 'test_helper'


class UserEntersNameWhenStartingTest < ActionDispatch::IntegrationTest
  test "user starts a test" do

    level = Level.create(title: "Level 1", text: "This is the easy test.")
    level.attempts.create(text: "This is the easy test.", name: "Frank")
    level.attempts.create(text: "This is the easy test.", name: "Susan")

    visit attempts_path
    assert page.has_content? "Frank: This is the easy test. Level: Level 1"
    assert page.has_content? "Susan: This is the easy test. Level: Level 1"
  end

  test "user visits '/attempts?name' and sees all of 'name's attempts" do
    level = Level.create(title: "Level 1", text: "This is the easy test.")
    level.attempts.create(text: "This is the easy test.", name: "Frank")
    level.attempts.create(text: "Abdfg hi 23 easy test.", name: "Frank")
    level.attempts.create(text: "s the easy test.", name: "Frank")

    level.attempts.create(text: "This is the easy test.", name: "Susan")
    level.attempts.create(text: "This is forsythe p jot", name: "Susan")
    level.attempts.create(text: "This is not the easy l", name: "Susan")

    visit "/attempts?name=Susan"
    assert page.has_no_content? "Frank: This is the easy test. Level: Level 1"
    assert page.has_no_content? "Frank: Abdfg hi 23 easy test. Level: Level 1"
    assert page.has_no_content? "Frank: s the easy test. Level: Level 1"
    assert page.has_content? "Susan: This is the easy test. Level: Level 1"
    assert page.has_content? "Susan: This is forsythe p jot Level: Level 1"
    assert page.has_content? "Susan: This is not the easy l Level: Level 1"
  end

  test "user fills in their name and starts test" do
    level = Level.create(title: "Level 1", text: "This is the easy test.")
    visit new_level_attempt_path(level)
    fill_in "Name:", with: "Susan"
    fill_in "Text", with: "This is the easy test."
    click_on "Score"

    save_and_open_page
    assert_equal level_path(level), current_path
    assert page.has_content? "Susan: This is the easy test. Level: Level 1"
  end
end
