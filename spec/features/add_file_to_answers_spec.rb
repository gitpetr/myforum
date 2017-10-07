require 'rails_helper'

RSpec.feature "AddFileToAnswers", type: :feature do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when answering', js: true do
    fill_in 'Ваш ответ', with: 'Test answer'
    puts "#{Rails.root}/spec/file/test.png"
    attach_file 'File', "#{Rails.root}/spec/file/test.png"
    click_on 'Сохранить'

    expect(page).to have_link 'test.png', href: %r(/uploads/attachment/file/\d+/test.png)
  end
end
