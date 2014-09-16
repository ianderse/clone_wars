require_relative './feature_test_helper'

class AdminTest < FeatureTest

  def test_it_can_log_in_as_admin
    visit '/my-account'

    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')

    assert page.has_css?('.edit-button')
  end
end
