require 'rails_helper'

RSpec.feature "CreateQuestions", type: :feature do
  given(:user) { create(:user) }
  scenario 'Authenticated User create question' do
  sign_in(user)

  visit questions_path
  click_on 'Новый вопрос'
  fill_in 'Title', with: 'Первый вопрос'
  fill_in 'Body', with: 'Текст вопроса'
  click_on 'Сохранить'

  expect(page).to have_content 'Вопрос успешно создан'
  end

  scenario 'Unauthenticated User fail to create question' do
    visit questions_path
    click_on 'Новый вопрос'

    expect(page).to have_content 'You need to sign in'
  end
end
