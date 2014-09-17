require_relative './feature_test_helper'

class AdminTest < FeatureTest

  def test_it_can_log_in
    visit '/my-account'
    within(input) do
      # ^ input isn't right, but we need something in its place
      fill_in('username', :with => 'Admin')
      fill_in('password', :with => 'pass')
      click_button('Login')

      assert page.has_css?('.edit-button')
    end
  end

  def test_it_can_log_out
    visit '/my-account'
    within(input) do
      # ^ input isn't right, but we need something in its place
      fill_in('username', :with => 'Admin')
      fill_in('password', :with => 'pass')
      click_button('Login')
      click_button('Logout')

    refute page.has_css?('.edit-button')
    end
  end

  def test_it_can_edit_products
    # log in through my account?
    # go to wholesale page?
    # edit
    # see edited product on page
  end
end

class UserTest < FeatureTest

  def test_it_cannot_edit_pages
    visit '/wholesale'
    refute page.has_css?('.edit-button')
  end
end
