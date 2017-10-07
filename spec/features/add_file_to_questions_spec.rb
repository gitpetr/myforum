require 'rails_helper'

RSpec.feature "AddFileToQuestions", type: :feature do

  let(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    attach_file 'File', "#{Rails.root}/spec/file/test.png" # предварительно положите файл в указанное место
    click_on 'Сохранить'

    expect(page).to  have_css("a[href*='test.png']") # два варианта как образец
    expect(page).to have_link 'test.png', href: %r(/uploads/attachment/file/\d+/test.png)

  end
end
