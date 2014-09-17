require_relative './feature_test_helper'

class AdminTest < FeatureTest

  def test_it_can_log_in
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    assert page.has_css?('#product-table')
  end

  def test_it_can_log_out
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    visit '/my-account'
    refute page.has_css?('#product-table')
  end

  def test_it_can_edit_products
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    within('#product-table') do
      first('.edit-button').click_link('Edit')
    end
    assert page.has_css?('.edit-item')
  end

end

class UserTest < FeatureTest

  def test_it_cannot_edit_pages
    visit '/my-account'
    click_button('Login')
    refute page.has_css?('#product-table')
  end

  def test_it_can_email_admin_through_contact_form
    visit '/contact-locations'
    fill_in('input_1', :with => 'Glen')
    fill_in('input_2', :with => 'glenegbert1@gmail.com')
    fill_in('input_3', :with => 'Hello')
    fill_in('input_4', :with => '303 898 8988')
    click_button('Send')

    assert page.has_css?('#message')
  end
end
