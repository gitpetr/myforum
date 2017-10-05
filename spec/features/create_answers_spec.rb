require 'rails_helper'

RSpec.feature "CreateAnswers", type: :feature do
  given(:user) { create(:user) }
  subject(:question) { create(:question) }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Ваш ответ', with: 'My answer'
    click_on 'Сохранить'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  # scenario 'User try to create invalid answer', js: true do
  #   sign_in user
  #   visit question_path(question)
  #
  #   click_on 'Create'
  #
  #   expect(page).to have_content "Body can't be blankBody can't be blank"
  # end
end
