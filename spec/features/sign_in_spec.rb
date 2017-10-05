require 'rails_helper'

RSpec.feature "SignIn", type: :feature do
  scenario 'Registered user try to sign in' do
    User.create(email: 'user@test.com', password: '111111', password_confirmation: '111111')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '111111'
    click_on 'Log in'
    # save_and_open_page # если нужно посмотреть страницу

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
