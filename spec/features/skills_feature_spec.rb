require 'rails_helper'

feature 'Adding skills to a user profile' do

  before do
    visit '/users/sign_up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
  end

  context 'when I am on my profile page' do

    scenario 'I can add a learnable' do
      visit '/'
      click_link 'Learn'
      fill_in 'Skill', with: 'Cooking'
      click_button 'Add learnable'
      expect(current_path).to eq '/'
      expect(page).to have_content 'Cooking'
    end

    scenario 'I can add a shareable' do
      visit '/'
      click_link 'Teach'
      fill_in 'Skill', with: 'Baking'
      click_button 'Add shareable'
      expect(current_path).to eq '/'
      expect(page).to have_content 'Baking'
    end

    scenario 'I can see my matches after I add a learnable' do
      visit '/'
      click_link 'Teach'
      fill_in 'Skill', with: 'Baking'
      click_button 'Add shareable'
      visit '/'
      click_link 'Sign out'
      visit '/users/sign_up'
      fill_in 'Email', with: 'newperson@person.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button 'Sign up'
      visit '/'
      click_link 'Learn'
      fill_in 'Skill', with: 'Baking'
      click_button 'Add learnable'
      expect(page).to have_content 'test@test.com'
    end

  end

end