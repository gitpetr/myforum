require 'rails_helper'

RSpec.feature "CreateQuestions", type: :feature do
  scenario 'Authenticated User create question' do
  User.create!(email: 'user1@test.com', password: '111111', password_confirmation: '111111')

  visit new_user_session_path
  fill_in 'Email', with: 'user@test.com'
  fill_in 'Password', with: '111111'
  click_on 'Log in'

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
